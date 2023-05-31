import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Utility/difficulty_controller.dart';
import 'package:quiz_app/Utility/score_controller.dart';
import 'package:quiz_app/src/ResultPage.dart';
import 'package:quiz_app/src/quiz_template.dart';
import 'package:quiz_app/src/intro_page.dart';
import 'package:quiz_app/src/quiz_page.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ControlDifficulty()),
          ChangeNotifierProvider(create: (_) => ScoreController()),
        ],
        child: const QuizHome(),
      ),
  );
}

class QuizHome extends StatelessWidget {
  const QuizHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroPage(),
        '/quiz': (context) => const QuizPage(),
        '/template': (context) => const QuizTemplatePage(),
        '/result': (context) => const ResultPage(),
      },
    );
  }
}