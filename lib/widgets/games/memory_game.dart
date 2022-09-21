import 'package:audioplayers/audioplayers.dart';
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
  CardInfo? firstCard;
  late List<CardInfo> cards;
  int numberOfTries = 0;
  bool gameOver = false;
  static AudioCache player = AudioCache();

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

        if (firstCard == null) {
          firstCard = card;
          firstCard!.isFlipped = true;
        } else {
          numberOfTries++;
          if (firstCard!.person == card.person) {
            // correct
            card.isMatched = true;
            firstCard!.isMatched = true;
            //play soundeffect
            player.play("sounds/success.mp3");
            firstCard = null;
          } else {
            //  wait 1 second and flip back
            Future.delayed(Duration(seconds: 1), () {
              setState(() {
                card.isFlipped = false;
                firstCard!.isFlipped = false;
                firstCard = null;
              });
            });
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
                      onPressed: () => widget.gameManager
                          .nextGame(context, 100 ~/ numberOfTries),
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
