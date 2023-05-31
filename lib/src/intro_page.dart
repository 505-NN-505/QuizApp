import 'dart:async';

import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _QuizIntroPageState();
}

class _QuizIntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      // Navigate to the main screen after a 5-second delay
      Navigator.pushReplacementNamed(context, '/quiz');
    });
    return const Scaffold(
      body: Center(
        child: Text(
          'MathQuiz',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }
}