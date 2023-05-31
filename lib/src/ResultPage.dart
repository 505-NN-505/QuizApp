import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Utility/score_controller.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _score = context.read<ScoreController>().score;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 6,),
            Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListTile(
                leading: const Icon(Icons.format_overline_rounded, size: 60, color: Colors.redAccent,),
                trailing: const Icon(Icons.ac_unit_sharp, size: 60, color: Colors.redAccent,),
                enabled: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                title: const Text('Game Over!!!',
                  style: TextStyle(color: Colors.white70),),
                titleTextStyle: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                subtitle: Text('Your Score is: $_score'),
                subtitleTextStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                isThreeLine: true,
              ),
            ),
            Spacer(flex: 1,),
            FloatingActionButton(
              child: Icon(
                Icons.home,
                size: 50,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/quiz');
              },
            ),
            Spacer(flex: 6,),
          ],
        ),
      ),
    );
  }
}