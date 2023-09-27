
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobeasytask/Screens/Loginpage.dart';
import 'package:mobeasytask/Screens/examscreens.dart';

class Routes {
  //private constructor
  Routes._();
  static const pageToGoBackTo = "";
  static const exam = 'exam';
  static const login = 'login';

  static String currentRoute = exam;
  static String previousCustomerRoute = exam;

  static Route onGenerateRouted(RouteSettings routeSettings) {
    previousCustomerRoute = currentRoute;
    currentRoute = routeSettings.name ?? "";
    switch (routeSettings.name) {
      case exam:
        return ExamScreen.route(routeSettings);
      case login:
        return LoginScreen.route(routeSettings);
      default:
        return ExamScreen.route(routeSettings);
    }
  }
}
