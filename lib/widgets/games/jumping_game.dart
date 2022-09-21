import 'package:flutter/material.dart';
import 'package:it_case_2022/game_manager.dart';
import "dart:math";
import "../../models/person.dart";
import "../../theme/palette.dart";

import "../../generate_person_list.dart";
import '../game_components/jumping_game/face_cards_grid.dart';
import "../game_components/jumping_game/running_graphics.dart";
import "../game_components/jumping_game/number_of_clicks.dart";

class JumpingGame extends StatefulWidget {
  static const routeName = "jumping-game";
  final numberOfFaceCards = 4;
  final List<Person> personList;
  final GameManager gameManager;
  JumpingGame(this.gameManager, this.personList, {super.key});

  @override
  State<JumpingGame> createState() => _JumpingGameState();
}

class _JumpingGameState extends State<JumpingGame> {
  int score = 250;
  late int chosenCardIndex;
  late int correctPersonIndex;
  late int correctPersonIndexActual;

  late List<Person> randomPersonList;
  NumberOfClicks numberOfClicks = NumberOfClicks();

  // TODO make sure a previously guessed name doesn't reappear (might cause problem?)
  //Solution should be to change correctIndex, and if none have not yet been chosen, create new list

  void generateNewPersonList() {
    List<Person> newRandomPersonList = generatePersonList(widget.personList, 4);
    var randomGenerator = Random();
    int randomIndex = randomGenerator.nextInt(newRandomPersonList.length);
    setState(
      (() {
        randomPersonList = newRandomPersonList;
        correctPersonIndex = randomIndex;
        correctPersonIndexActual = randomPersonList[randomIndex].index!;
      }),
    );
  }

  void chooseCard(int index) {
    setState(() => chosenCardIndex = index);
    if (index == randomPersonList[correctPersonIndex].index) {
      print("Correct");
    } else {
      print("Wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    generateNewPersonList();
    // final routeArgs =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final categoryTitle = routeArgs["title"];
    // final categoryId = routeArgs["id"];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Container(),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                randomPersonList[correctPersonIndex].name,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: RunningGraphics(widget.gameManager, numberOfClicks),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Palette.primaryBackground,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: ElevatedButton(
                child: Text("Next"),
                onPressed: () => widget.gameManager.nextGame(context, score),
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: FaceCardsGrid(
              randomPersonList: randomPersonList,
              onPressed: chooseCard,
              numberOfClicks: numberOfClicks,
              generateNewPersonList: generateNewPersonList,
              correctPersonIndex: correctPersonIndexActual,
            ),
          )
        ],
      ),
    );
  }
}
