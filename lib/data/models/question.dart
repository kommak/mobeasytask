

//Question model
class Question {
  String? id;
  String? question;
  String? ans1;
  String? ans2;
  String? ans3;
  String? ans4;
  String? corect;
  Question({this.id, this.question, this.ans1, this.ans2,this.ans3,this.ans4,this.corect});

  //Convert data from Map To model
  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    question = json['question'];
    ans1 = json['ans1'];
    ans2 = json['ans2'];
    ans3 = json['ans3'];
    ans4 = json['ans4'];
    corect = json['corect'];
  }


  //Convert data from model To map
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'ans1': ans1,
      'ans2': ans2,
      'ans3': ans3,
      'ans4': ans4,
      'corect': corect,
    };
  }

}


