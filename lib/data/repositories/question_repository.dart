import 'dart:developer';

import '../models/data_output.dart';
import '../models/question.dart';



class QuestionRepository {
  Future<DataOutput<Question>> fetchQuestions({
    required int offset,
  }) async {

    //here I used sample data if the data will come from api the get data function will be here

    List<Question> modelList = [];
    Question q1=Question(
      id: "1",
      question: "1+1",
      ans1: "3",
      ans2: "4",
      ans3: "2",
      ans4: "6",
      corect: "2"
    );
    Question q2=Question(
        id: "2",
        question: "2+2",
        ans4: "3",
        ans1: "4",
        ans2: "2",
        ans3: "6",
        corect: "4"
    );
    Question q3=Question(
        id: "3",
        question: "3+3",
        ans2: "3",
        ans3: "4",
        ans1: "2",
        ans4: "6",
        corect: "6"
    );
    modelList.add(q1);
    modelList.add(q2);
    modelList.add(q3);
    return DataOutput(total: modelList.length, modelList: modelList);
  }
}
