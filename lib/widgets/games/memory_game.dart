import 'package:flutter/material.dart';
import 'package:it_case_2022/generate_person_list.dart';
import 'package:it_case_2022/models/person.dart';
import '../../game_manager.dart';
import "../game_components/memory_game/flip_card.dart";

class MemoryGame extends StatefulWidget {
  static const routeName = "memory-game";
  final GameManager gameManager;
  final List<Person> persons;
  final List<Person> selectedPersons;
  MemoryGame(this.gameManager, this.persons, {super.key})
      : selectedPersons = generatePersonList(persons, 4);

  @override
  State<MemoryGame> createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  Person? selectedPerson;
  late List<CardInfo> cards;
  int score = 0;
  bool gameOver = false;

  @override
  void initState() {
    cards = [];
    widget.selectedPersons.forEach((element) {
      cards.add(CardInfo(
          person: element,
          showImage: true,
          isFlipped: false,
          isMatched: false));
      cards.add(CardInfo(
          person: element,
          showImage: false,
          isFlipped: false,
          isMatched: false));
    });
    cards.shuffle();
    super.initState();
  }

  void personCardClicked(CardInfo card) {
    setState(() {
      if (!card.isFlipped) {
        card.isFlipped = true;

        if (selectedPerson == null) {
          selectedPerson = card.person;
        } else {
          if (selectedPerson == card.person) {
            cards.forEach((element) {
              if (element.person == card.person && element.isFlipped) {
                element.isMatched = true;
              }
            });
            selectedPerson = null;
          } else {
            cards.forEach((element) {
              if (element.person == card.person &&
                  element.showImage == card.showImage) {
                element.isFlipped = true;
              }
              if (element.person == selectedPerson) {
                element.isFlipped = false;
              }
            });
            selectedPerson = card.person;
          }
        }
        // if all cards are matched, set gameOver to true
        if (cards.every((element) => element.isMatched)) {
          gameOver = true;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: GridView(
                padding: const EdgeInsets.all(25),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                children:
                    cards.map((c) => FlipCard(c, personCardClicked)).toList(),
              )),
              gameOver
                  ? ElevatedButton(
                      child: Text("Next"),
                      onPressed: () =>
                          widget.gameManager.nextGame(context, 100),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class CardInfo {
  final Person person;
  bool showImage;
  bool isFlipped;
  bool isMatched;
  CardInfo(
      {required this.person,
      required this.showImage,
      required this.isFlipped,
      required this.isMatched});
}
