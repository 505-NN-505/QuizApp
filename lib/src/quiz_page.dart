import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/Utility/difficulty_controller.dart';
import 'package:quiz_app/Utility/score_controller.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 5,),
          const Center(
            child: SizedBox(
              height: 250,
              width: 250,
              child: Image(
                image: AssetImage('assets/math.png'),
              ),
            ),
          ),
          const Spacer(flex: 1,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 10,),

              FloatingActionButton(
                heroTag: null,
                  child: const Icon(
                    Icons.play_arrow_rounded
                  ),
                onPressed: (){
                  context.read<ScoreController>().resetScore();
                  Navigator.pushNamed(context, '/template');
                }
                ),

                const Spacer(flex: 1),

              FloatingActionButton(
                  heroTag: null,
                  child: const Icon(
                      Icons.monitor_heart
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          title: const Text('Choose Difficulty'),
                          titleTextStyle: GoogleFonts.roboto(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                ListTile(
                                  title: const Text('Easy'),
                                  onTap: () {
                                    setState(() {
                                      context.read<ControlDifficulty>().setDifficulty(0);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('Medium'),
                                  onTap: () {
                                    setState(() {
                                      context.read<ControlDifficulty>().setDifficulty(1);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  title: const Text('Hard'),
                                  onTap: () {
                                    setState(() {
                                      context.read<ControlDifficulty>().setDifficulty(2);
                                    });
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
              ),
              const Spacer(flex: 10,),
            ],
          ),
          const Spacer(flex: 5,),
        ],
      ),
    );
  }
}
