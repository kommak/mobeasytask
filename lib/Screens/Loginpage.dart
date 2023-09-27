

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _loginscreen();
  }

  static Route<LoginScreen> route(RouteSettings routeSettings) {
    Map? args = routeSettings.arguments as Map?;
    return CupertinoPageRoute(
      builder: (_) => LoginScreen(),
    );
  }

}

class _loginscreen extends State<LoginScreen>{


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
  return
    Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Center(child: InkWell(child:Container(
          height: 50,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          child: Center(child:
            Text("Google Login",style: TextStyle(color: Colors.white),)
            ,),
        ),
        onTap: ()async{
          signInWithGoogle().then((value) {
            Navigator.of(context).pushNamed('exam');
          });
        },
        )),
      ),
    )
    ;
  }

}