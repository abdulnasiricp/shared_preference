import 'dart:async';
import 'package:clickcounter/admin_view.dart';
import 'package:clickcounter/login_screen.dart';
import 'package:clickcounter/student_view.dart';
import 'package:clickcounter/teacher_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool('isLogin') ?? false;
    String userType = sp.getString('userType') ?? '';

    if (isLogin) {
      if (userType == 'student') {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const StudentView()));
        });
      } else if (userType == 'teacher') {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const TeacherView()));
        });
      } else {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AdminView()));
        });
      }
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Image(
      height: double.infinity,
      fit: BoxFit.fitHeight,
      image: NetworkImage(
          'https://images.pexels.com/photos/4709288/pexels-photo-4709288.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    ));
  }
}
