import "package:flutter/material.dart";
import '../widgets/high_scores.dart';
import 'package:it_case_2022/widgets/games/wordle_game/namle.dart';
import "dart:math";

import '../models/person.dart';
import 'games/memory_game.dart';
import 'games/jumping_game.dart';
import 'big_button.dart';

class StartScreen extends StatefulWidget {
  final List<Person>? allPersons;
  StartScreen({this.allPersons, super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final List<Color> colorList = [
    Colors.red,
    Colors.yellow,
    Colors.deepOrange,
    Colors.cyan,
    Colors.green,
    Colors.deepPurple,
  ];

  late Color backgroundColor1;
  late Color backgroundColor2;

  void generateNewBackgroundColors() {
    var randomGenerator = Random();
    int generateRandomIndex() {
      return randomGenerator.nextInt(colorList.length);
    }

    int lastIndex = generateRandomIndex();
    int newIndex = generateRandomIndex();
    while (lastIndex == newIndex) {
      newIndex = generateRandomIndex();
    }
    setState(() {
      backgroundColor1 = colorList[lastIndex];
      backgroundColor2 = colorList[newIndex];
    });
  }

  void startMemoryGame(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MemoryGame.routeName, /*arguments: {"id": id, "title": title}*/
    );
    generateNewBackgroundColors();
  }

  void startJumpingGame(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      JumpingGame.routeName, /*arguments: {"id": id, "title": title}*/
    );
    generateNewBackgroundColors();
  }

  void showHighScores(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      HighScores.routeName, /*arguments: {"id": id, "title": title}*/
    );
    generateNewBackgroundColors();
  }

  void startNamleGame(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      NamlePage.routeName, /*arguments: {"id": id, "title": title}*/
    );
    generateNewBackgroundColors();
  }

  @override
  Widget build(BuildContext context) {
    generateNewBackgroundColors();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              backgroundColor1,
              backgroundColor2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "navneVerket:",
                style: Theme.of(context).textTheme.headline1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "en",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  widget.allPersons != null
                      ? Text(
                          "itCASE",
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : Text("yo"),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    BigButton("Namle", startNamleGame),
                    BigButton("Start Game", startJumpingGame),
                    BigButton("Show High Scores", showHighScores),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
