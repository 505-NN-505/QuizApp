import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Utility/difficulty_controller.dart';
import 'package:quiz_app/Utility/random_math_expression.dart';
import 'package:quiz_app/Utility/score_controller.dart';

class QuizTemplatePage extends StatefulWidget {
  const QuizTemplatePage({Key? key}) : super(key: key);

  @override
  State<QuizTemplatePage> createState() => _QuizTemplatePageState();
}

class _QuizTemplatePageState extends State<QuizTemplatePage> {
  late String _expression;
  late int _difficulty, _answer;
  late List<int> _options;
  int _life = 3;

  late Timer _timer;

  int _seconds = 5;
  bool isTimeUp = false;
  bool skipped = true;
  double progress = 1.0;

  void generateTemplate() {
    _difficulty = context.read<ControlDifficulty>().difficulty;
    _expression = RandomMathExpression.generateExpression(_difficulty);
    _answer = RandomMathExpression.evaluateExpression(_expression);
    _options = RandomMathExpression.generateOptions(_answer, _difficulty);
    skipped = true;
    progress = 1.0;
    buttonTaps = [0, 0, 0, 0];
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _seconds--;
        progress -= 0.2;
        if (_seconds <= 0) {
          isTimeUp = true;
          _timer.cancel();
        }
      });
    });
  }

  int getScore() {
    return context.read<ScoreController>().score;
  }

  void resetTimer() {
    _timer.cancel();
    setState(() {
      _seconds = 5;
      progress = 1.0;
      isTimeUp = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    generateTemplate();
    startTimer();
    super.initState();
  }

  List<int> buttonTaps = [0, 0, 0, 0];

  void _updateButtonState(int index) {
    setState(() {
      buttonTaps[index] += 1;
    });
  }

  Color _getButtonColor(int index, int number) {
    if (buttonTaps[index] == 1) {
      if (number == _answer) {
        return Colors.greenAccent;
      } else {
        return Colors.redAccent;
      }
    }
    else {
      if (!isTimeUp) {
        return Colors.orangeAccent;
      } else {
        return Colors.grey;
      }
    }
  }

  Widget _buildNumberButton(int index, int number) {
    void _handleNumberTap(int number) {
      setState(() {
        if (!isTimeUp) {
          _updateButtonState(index);
          if (number == _answer) {
            context.read<ScoreController>().increaseScore();
          }
          else {
            _life--;
            if (_life == 0) {
              Navigator.pushReplacementNamed(context, '/result');
            }
          }
          _timer.cancel();
          skipped = false;
        }
      });
    }
    return InkWell(
      onTap: () => _handleNumberTap(number),
      child: Container(
        decoration: BoxDecoration(
          color: _getButtonColor(index, number),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            Row(
              children: [
                const Spacer(flex: 1),
                Column(
                  children: [
                    const Icon(Icons.favorite, size: 30,),
                    Text('$_life',
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  ],
                ),
                const Spacer(flex: 5),
                Stack(
                alignment: Alignment.center,
                children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey,
                    color: Colors.blue,
                    strokeWidth: 15,
                  ),
                ),
                  Center(
                    child: Text(
                      '$_seconds',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ]),
                const Spacer(flex: 5),
                Column(
                  children: [
                    const Icon(Icons.local_activity_rounded, size: 30),
                    Text(getScore().toString(),
                      style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Spacer(flex: 1),
              ],
            ),
            const Spacer(flex: 2,),
            Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListTile(
                leading: const Icon(Icons.numbers_rounded, size: 50, color: Colors.white70,),
                enabled: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                title: Text('$_expression',
                style: const TextStyle(color: Colors.white70),),
                tileColor: Colors.indigoAccent,
                textColor: Colors.black87,
                titleTextStyle: const TextStyle(fontSize: 43, fontWeight: FontWeight.bold),
                trailing: const Icon(Icons.question_mark_sharp, size: 40, color: Colors.white70,),
              ),
            ),
            const Spacer(flex: 1,),
            Expanded(
              flex: 15,
              child: GridView.count(
                crossAxisCount: 2, // Number of columns in the grid
                padding: const EdgeInsets.all(16.0),
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: <Widget>[
                  _buildNumberButton(0, _options[0]),
                  _buildNumberButton(1, _options[1]),
                  _buildNumberButton(2, _options[2]),
                  _buildNumberButton(3, _options[3]),
                ],
              ),
            ),
            const Spacer(flex: 2,),
            FloatingActionButton(
              child: const Icon(Icons.navigate_next_rounded),
              onPressed: () {
                setState(() {
                  if (skipped) _life--;
                  if (_life == 0) {
                    Navigator.pushReplacementNamed(context, '/result');
                  }
                });
                resetTimer();
                generateTemplate();
                startTimer();
              }),
            const Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }
}