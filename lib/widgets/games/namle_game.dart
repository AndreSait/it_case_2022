import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../game_manager.dart';
import '../../generate_person_list.dart';

import '../../models/person.dart';
import '../game_components/namle_game/keyboard.dart';

// TODO:
// 1. Gi feedback på riktig svar og game over (pil til neste game) [SOLVED]
// 2. Fikse antall gule i svaret (slik det er på wordle)

class NamleGame extends StatefulWidget {
  static const String routeName = "namle-game";
  final List<Person> persons;
  final Person person;
  final GameManager gameManager;

  NamleGame(this.gameManager, this.persons, {super.key})
      : person = generatePersonList(persons, 1)[0];
  @override
  State<NamleGame> createState() => _NamleGameState();
}

class _NamleGameState extends State<NamleGame> {
  final int _maxTries = 5;

  bool gameIsFinished = false; // Deciding whether to show button or keyboard
  bool hasWon = false; // Deciding whether to show next/game-over button

  String guess = "";
  Map<String, Color> colorOfLetter = {};

  List<String> previousGuessArray = [];

  String getFirstName(Person person) {
    return person.name.split(" ")[0].toUpperCase();
  }

  bool testAttempt(String name) {
    previousGuessArray.add(guess);
    if (guess == name) {
      guess = "";
      return true;
    } else {
      guess = "";
      return false;
    }
  }

  void keyBoardClicked(String c) {
    String name = getFirstName(widget.person);
    if (c == "*") {
      // Backspace
      if (guess.isNotEmpty) {
        setState(() {
          guess = guess.substring(0, guess.length - 1);
        });
      }
    } else if (c == "+") {
      // Enter
      if (guess.length == name.length) {
        setState(() {
          bool success = testAttempt(name);
          if (success) {
            print("Name guessed after ${previousGuessArray.length} tries");
            gameIsFinished = true;
            hasWon = true;
          } else if (previousGuessArray.length >= _maxTries) {
            gameIsFinished = true;
          }
        });
      }
    } else {
      if (guess.length < name.length) {
        setState(() {
          guess += c;
        });
      }
    }
  }

  Color getColorOfChar(String c, int rowIndex, int charIndex, String name) {
    if (rowIndex >= previousGuessArray.length) {
      // For current row and below
      return Colors.transparent;
    } else if (name[charIndex] == c) {
      colorOfLetter[c] = Colors.green;
      return Colors.green;
    } else if (name.contains(c)) {
      if (!colorOfLetter.containsKey(c)) {
        // Only set if not yet colored, to avoid overriding green
        colorOfLetter[c] = Colors.yellow;
      }
      return Colors.yellow;
    }
    colorOfLetter[c] = Color.fromARGB(255, 171, 171, 171);
    return Color.fromARGB(255, 171, 171, 171);
  }

  String getCharacter(rowIndex, charIndex) {
    // Previous rows
    if (rowIndex < previousGuessArray.length) {
      String guess = previousGuessArray[rowIndex];
      return guess[charIndex];
    }
    // Current row
    else if (rowIndex == previousGuessArray.length) {
      if (charIndex < guess.length) {
        return guess[charIndex];
      } else {
        return "";
      }
    }
    // Following rows
    else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = getFirstName(widget.person);
    int gridWidthCount = name.length;
    double viewPortWidth = MediaQuery.of(context).size.width;
    double calculatedWidth = 50.0 * gridWidthCount;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: image(widget.person.imageUrl),
        ),
        // Gridview for guessing
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints:
                  BoxConstraints(maxWidth: min(calculatedWidth, viewPortWidth)),
              child: GridView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridWidthCount,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 4),
                children: List.generate(gridWidthCount * _maxTries, (index) {
                  int rowIndex = index ~/ gridWidthCount;
                  int charIndex = index % gridWidthCount;
                  var char = getCharacter(rowIndex, charIndex);
                  return Container(
                    decoration: BoxDecoration(
                        color: getColorOfChar(char, rowIndex, charIndex, name),
                        border: Border.all(color: Colors.grey, width: 3)),
                    child: Center(
                        child:
                            Text(char, style: const TextStyle(fontSize: 20))),
                  );
                }),
              ),
            ),
          ],
        ),
        gameIsFinished
            ? (!hasWon)
                ? // Game was lost
                Column(
                    children: [
                      Text("This is ${getFirstName(widget.person)}",
                          style: TextStyle(fontSize: 20)),
                      SizedBox(height: 20),
                      ElevatedButton(
                        child: Text("Show Score"),
                        onPressed: () => widget.gameManager.endGame(context, 0),
                      )
                    ],
                  )
                : ElevatedButton(
                    child: Text("Next"),
                    onPressed: () => widget.gameManager.nextGame(
                        context,
                        (widget.gameManager.maxScoreForSingleGame *
                                ((_maxTries - (previousGuessArray.length - 1)) /
                                    _maxTries))
                            .toInt()),
                  )
            : Keyboard(keyBoardClicked, colorOfLetter),
      ],
    ));
  }

  Widget image(String url) {
    return SizedBox(
      width: 250,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (ctx, str) => SizedBox.expand(
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
          )),
    );
  }
}
