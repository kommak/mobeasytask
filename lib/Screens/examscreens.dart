

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobeasytask/data/cubit/fetch_questions_cubit.dart';
import 'package:mobeasytask/data/models/question.dart';
import 'package:mobeasytask/data/models/student.dart';

class ExamScreen extends StatefulWidget{
  const ExamScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _examscreen();
  }


  static Route<ExamScreen> route(RouteSettings routeSettings) {
    Map? args = routeSettings.arguments as Map?;
    return CupertinoPageRoute(
      builder: (_) => ExamScreen(),
    );
  }
}

class  _examscreen extends State<ExamScreen>{

  @override
  void initState() {
    // TODO: implement initState

    //read questions from cubit
    context.read<FetchQuestionCubit>().fetchQuestions();

    //make some students samples for leaderboard
    Student student1=Student(
      name: "Ahmed Jomaa",
      mark: 22.5
    );
    Student student2=Student(
        name: "Yones Mohammad",
        mark: 31
    );
    Student student3=Student(
        name: "Farah Zaher",
        mark: 34
    );
    Student student4=Student(
        name: "Diaa Ismaeel",
        mark: 18
    );
    Student student5=Student(
        name: "Rafaat Najjar",
        mark: 28
    );
    students.addAll([student1,student2,student3,student4,student5]);

    super.initState();
  }

  int index=0;
  String selected='';

  //here i will save my answers
  List<Map> myanswers=[];


  bool finish =false;
  bool leaderboard =false;

  //students leaderboard
  List<Student> students=[];



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    // TODO: implement build
    return
      Scaffold(
          body:
          !finish?BlocConsumer<FetchQuestionCubit, FetchQuestionState>(
            listener: (context, state) {
              if (state is FetchQuestionSuccess) {
                setState(() {});
              }
            },
            builder: (context, state) {
              if (state is FetchQuestionInProgress) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      // CustomShimmer(
                      //   height: 50.rh(context),
                      //   width: context.screenWidth,
                      // ),
                      Container(
                        height: 50,
                        width: width,
                        child: Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )

                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              }
              if (state is FetchQuestionFailure) {
                return Container();
              }
              if (state is FetchQuestionSuccess) {
                if (state.quuestions.isNotEmpty) {
                  List<Question> questions=state.quuestions;
                  return
                    Container(
                      height: height,
                      width: width,
                      child:  Stack(
                        children: [
                          Container(
                            height: 300,
                            width: width,
                            color: Colors.white,
                            child: Center(
                              child: Text(questions[index].question??'',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: 300,
                              child:
                              Container(
                                height: height-300,
                                width: width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.all(Radius.circular(35))
                                ),
                                child: Column(
                                  children: [
                                     SizedBox(
                                       height: 50,
                                     ),
                                    Row(
                                      children: [
                                        Spacer(),
                                        InkWell(child:Container(
                                          width: 150,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                              color: selected!=questions[index].ans1?Colors.blue:Colors.green
                                          ),
                                          child: Center(
                                            child: Text(questions[index].ans1??'',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                                          ),
                                        ),
                                          onTap: (){
                                              selected=questions[index].ans1.toString();
                                              setState(() {});
                                          },
                                        ),
                                        SizedBox(width: 50,),
                                        InkWell(child:Container(
                                          width: 150,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                              color:selected!=questions[index].ans2?Colors.blue:Colors.green
                                          ),
                                          child: Center(
                                            child: Text(questions[index].ans2??'',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                                          ),
                                        ),
                                          onTap: (){
                                            selected=questions[index].ans2.toString();
                                            setState(() {});
                                          },
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Row(
                                      children: [
                                        Spacer(),
                                        InkWell(child:Container(
                                          width: 150,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                              color: selected!=questions[index].ans3?Colors.blue:Colors.green
                                          ),
                                          child: Center(
                                            child: Text(questions[index].ans3??'',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                                          ),
                                        ),
                                          onTap: (){
                                            selected=questions[index].ans3.toString();
                                            setState(() {});
                                          },
                                        ),
                                        SizedBox(width: 50,),
                                        InkWell(child:Container(
                                          width: 150,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                              color:selected!=questions[index].ans4?Colors.blue:Colors.green
                                          ),
                                          child: Center(
                                            child: Text(questions[index].ans4??'',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                                          ),
                                        ),
                                          onTap: (){
                                            selected=questions[index].ans4.toString();
                                            setState(() {});
                                          },
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                  ],
                                ),
                              )
                          ),
                          Positioned(
                              bottom: 40,
                              child: Container(
                                width: width,
                                height: 50,
                                child: Center(
                                  child: InkWell(child:Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        color: Colors.black54
                                    ),
                                    child: Center(
                                      child: Text("Next",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                                    ),
                                  ),
                                    onTap: (){
                                    //save my answer
                                      Map ans=Map();
                                      ans['question']=(index+1).toString();
                                      ans['answer']=selected;
                                      ans['correct']=questions[index].corect;
                                      myanswers.add(ans);
                                      if(index<questions.length-1){
                                        //if there is more question will show the next one
                                        setState((){
                                          index++;
                                          selected='';
                                        });
                                      }
                                      else{
                                        //if there is no more question the answers will be saved to firebase and then show my answers
                                       var db = FirebaseFirestore.instance;
                                       final answers = <String, dynamic>{
                                         "Name": "Komai Makarem",
                                         "Answers": myanswers
                                       };
                                       db.collection("answers").add(answers);
                                       setState(() {
                                          finish=true;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              )

                          )
                        ],
                      ),
                    );
                }
                else{
                  return Container();
                }
              }
              return Container();
            },
          ):!leaderboard?
              Padding(padding: EdgeInsets.all(25),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 40,),
                      Text("Your results",style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 20,),
                      for(var i in myanswers)
                        Container(
                          height: 50,
                          child: Row(
                            children: [
                              Text("Number " + i['question']+ " : "+i['answer'],style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),),
                              Spacer(),
                              if(i['answer']==i['correct'])
                                Icon(Icons.check,color: Colors.green,size: 35,),
                              if(i['answer']!=i['correct'])
                                Icon(Icons.clear,color: Colors.red,size: 35),
                            ],
                          ),
                        )
                    ],
                  ),
                  Positioned(
                      bottom: 40,
                      child: Container(
                        width: width-50,
                        height: 50,
                        child: Center(
                          child: InkWell(child:Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.black54
                            ),
                            child: Center(
                              child: Text("Show leaderboard",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),
                            ),
                          ),
                            onTap: (){
                            // here mymark will be calculated and then add me to students list
                            double mymark=0;
                            for(var i in myanswers){
                              if(i['answer']==i['correct']){
                                mymark=mymark+13.5;
                              }
                            }
                            Student me=Student(name: "Me",mark: mymark);
                            students.add(me);
                            
                            // after adding me to list the list will be sorted to know the highest mark and the winner
                            // after sorting the leaderboard will be shown
                            students.sort((a, b) => b.mark!.compareTo(a.mark!));
                            setState(() {
                              leaderboard=true;
                            });
                            },
                          ),
                        ),
                      )

                  )
                ],
              )
              ):
          Padding(padding: EdgeInsets.all(25),
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 40,),
                      Text("Leaderboard",style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 20,),
                      for(int i=0 ; i<students.length;i++)
                        Container(
                          height: 50,
                          child: Row(
                            children: [
                              Text((i+1).toString()+" - ",style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text( students[i].name.toString(),style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                              Spacer(),
                              Text("Mark " + students[i].mark.toString(),style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                            ],
                          ),
                        )
                    ],
                  ),

                ],
              )
          )


      )
      ;
  }

}