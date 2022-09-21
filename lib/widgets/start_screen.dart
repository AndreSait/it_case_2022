import "package:flutter/material.dart";
import 'package:it_case_2022/game_manager.dart';
import "dart:math";

import '../widgets/games/namle_game.dart';
import '../widgets/games/memory_game.dart';
import '../widgets/games/jumping_game.dart';
import '../widgets/high_scores.dart';
import '../models/person.dart';
import './big_button.dart';
import 'dart:async';

class StartScreen extends StatefulWidget {
  final List<Person>? allPersons;
  final GameManager gameManager;
  StartScreen({this.allPersons, required this.gameManager, super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 20), () => generateNewBackgroundColors());
    Timer.periodic(Duration(seconds: 5), (timer) {
      generateNewBackgroundColors();
    });
    generateNewBackgroundColors();
  }

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

  void showHighScores(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      HighScores.routeName, /*arguments: {"id": id, "title": title}*/
    );
    generateNewBackgroundColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(seconds: 5),
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
                    BigButton(
                        "Namle Game",
                        (context) => widget.gameManager
                            .startNewGame(context, NamleGame.routeName)),
                    BigButton(
                        "Memory Game",
                        (context) => widget.gameManager
                            .startNewGame(context, MemoryGame.routeName)),
                    BigButton(
                        "Jumping Game",
                        (context) => widget.gameManager
                            .startNewGame(context, JumpingGame.routeName)),
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
