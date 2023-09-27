// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:developer';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobeasytask/data/models/question.dart';
import 'package:mobeasytask/data/repositories/question_repository.dart';

import '../models/data_output.dart';


abstract class FetchQuestionState {}

class FetchQuestionInitial extends FetchQuestionState {}

class FetchQuestionInProgress extends FetchQuestionState {}

class FetchQuestionSuccess extends FetchQuestionState {
  final int total;
  final int offset;
  final bool isLoadingMore;
  final bool hasError;
  final List<Question> quuestions;
  FetchQuestionSuccess({
    required this.total,
    required this.offset,
    required this.isLoadingMore,
    required this.hasError,
    required this.quuestions,
  });

  FetchQuestionSuccess copyWith({
    int? total,
    int? offset,
    bool? isLoadingMore,
    bool? hasError,
    List<Question>? categories,
  }) {
    return FetchQuestionSuccess(
      total: total ?? this.total,
      offset: offset ?? this.offset,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasError: hasError ?? this.hasError,
      quuestions: categories ?? this.quuestions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'offset': offset,
      'isLoadingMore': isLoadingMore,
      'hasError': hasError,
      'questions': quuestions.map((x) => x.toMap()).toList(),
    };
  }

  factory FetchQuestionSuccess.fromMap(Map<String, dynamic> map) {
    return FetchQuestionSuccess(
      total: map['total'] as int,
      offset: map['offset'] as int,
      isLoadingMore: map['isLoadingMore'] as bool,
      hasError: map['hasError'] as bool,
      quuestions: List<Question>.from(
        (map['questions']).map<Question>(
          (x) => Question.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FetchQuestionSuccess.fromJson(String source) =>
      FetchQuestionSuccess.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FetchCategorySuccess(total: $total, offset: $offset, isLoadingMore: $isLoadingMore, hasError: $hasError, quuestions: $quuestions)';
  }
}

class FetchQuestionFailure extends FetchQuestionState {
  final String errorMessage;

  FetchQuestionFailure(this.errorMessage);
}

class FetchQuestionCubit extends Cubit<FetchQuestionState> with HydratedMixin {
  FetchQuestionCubit() : super(FetchQuestionInitial());
  final QuestionRepository _questionRepository = QuestionRepository();

  fetchQuestions({bool? forceRefresh}) async {
    try {
      if (forceRefresh != true) {
        if (state is FetchQuestionSuccess) {
          await Future.delayed(const Duration(seconds: 2));
          // });
        } else {
          emit(FetchQuestionInProgress());
        }
      } else {
        emit(FetchQuestionInProgress());
      }
      DataOutput<Question> questions =
          await _questionRepository.fetchQuestions(offset: 0);

      emit(FetchQuestionSuccess(
          total: questions.total,
          quuestions: questions.modelList,
          offset: 0,
          hasError: false,
          isLoadingMore: false));
    } catch (e) {
      emit(FetchQuestionFailure(e.toString()));
    }
  }


  @override
  FetchQuestionState? fromJson(Map<String, dynamic> json) {
    try {
      var state = json['cubit_state'];

      if (state == "FetchQuestionSuccess") {
        return FetchQuestionSuccess.fromMap(json);
      }
    } catch (e) {
      log("Question from map error $e");
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(FetchQuestionState state) {
    if (state is FetchQuestionSuccess) {
      Map<String, dynamic> mapped = state.toMap();

      mapped['cubit_state'] = "FetchQuestionSuccess";

      return mapped;
    }

    return null;
  }
}
