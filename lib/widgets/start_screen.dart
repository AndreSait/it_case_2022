import "package:flutter/material.dart";
import "dart:math";

import 'big_button.dart';

class StartScreen extends StatefulWidget {
  StartScreen({super.key});

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
                  Text(
                    "itCASE",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    BigButton("Start Game", () {}),
                    BigButton("Show High Scores", () {}),
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
