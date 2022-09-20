import 'package:flutter/material.dart';
import 'package:it_case_2022/game_manager.dart';
import "dart:math";
import '../game_components/jumping_game/face_cards_grid.dart';
import "../../generate_person_list.dart";
import "../../models/person.dart";

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
  late List<Person> randomPersonList;

  //TODO make sure a previously guessed name doesn't reappear (might cause problem?)
  //Solution should be to change correctIndex, and if none have not yet been chosen, create new list

  void generateNewPersonList() {
    List<Person> newRandomPersonList = generatePersonList(widget.personList, 4);
    var randomGenerator = Random();
    int randomIndex = randomGenerator.nextInt(newRandomPersonList.length);
    setState(
      (() {
        randomPersonList = newRandomPersonList;
        correctPersonIndex = randomIndex;
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
            flex: 3,
            child: Container(),
          ),
          Expanded(
            flex: 14,
            child: Text(
              randomPersonList[correctPersonIndex].name,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 3,
            child: ElevatedButton(
              child: Text("Click"),
              onPressed: () => widget.gameManager.nextGame(context, score),
            ),
          ),
          Expanded(
            flex: 10,
            child: FaceCardsGrid(
                randomPersonList: randomPersonList, onPressed: chooseCard),
          )
        ],
      ),
    );
  }
}
