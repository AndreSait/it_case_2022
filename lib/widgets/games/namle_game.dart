import 'package:audioplayers/audioplayers.dart';
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

List<List<Color>> initcolor2DArray(rows, index) {
  List<List<Color>> color2DArray = [];
  for (int i = 0; i < rows; i++) {
    color2DArray.add([]);
    for (int j = 0; j < index; j++) {
      color2DArray[i].add(Colors.transparent);
    }
  }
  return color2DArray;
}

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
  static AudioCache player = AudioCache();

  bool gameIsFinished = false; // Deciding whether to show next/game-over button
  bool hasWon = false; // Deciding whether to show next/game-over button

  String guess = "";
  Map<String, Color> colorOfLetter = {};

  List<String> previousGuessArray = [];
  late List<List<Color>> color2DArray = initcolor2DArray(5, 50);

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          color2DArray =
              initcolor2DArray(_maxTries, getFirstName(widget.person).length)
        });
  }

  String getFirstName(Person person) {
    var name = person.name.split(" ")[0].toUpperCase();
    name = name.replaceAll("é", "e");
    return name;
  }

  bool testAttempt(String name) {
    previousGuessArray.add(guess);
    updateColor2DArray();
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
            player.play("sounds/success.mp3");
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

  void updateColor2DArray() {
    String name = getFirstName(widget.person);

    // Do the following for all rows above the current
    for (int i = 0; i < previousGuessArray.length; i++) {
      var row = previousGuessArray[i];
      var rowName = name.substring(0, row.length); // Deep copy of name

      // For each row
      // check for number of greens
      for (int j = 0; j < row.length; j++) {
        if (row[j] == name[j]) {
          color2DArray[i][j] = Colors.green;
          colorOfLetter[row[j]] = Colors.green; // Used for color on keyboard
        }
      }
      // Remove the same greens
      for (int j = 0; j < row.length; j++) {
        if (row[j] == name[j]) {
          rowName = rowName.substring(0, j) +
              "_" +
              rowName.substring(j + 1, rowName.length);
        }
      }

      // Check for number of yellows
      for (int j = 0; j < row.length; j++) {
        if (rowName.contains(row[j]) && color2DArray[i][j] != Colors.green) {
          color2DArray[i][j] = Colors.yellow;
          rowName = rowName.replaceFirst(row[j], "");

          if (!colorOfLetter.containsKey(row[j])) {
            // Only set if not yet colored, to avoid overriding green
            colorOfLetter[row[j]] = Colors.yellow;
          } else if (colorOfLetter[row[j]] ==
              Color.fromARGB(255, 171, 171, 171)) {
            colorOfLetter[row[j]] = Colors.yellow;
          }
        }
      }

      // Set the rest to grey
      for (int j = 0; j < row.length; j++) {
        if (color2DArray[i][j] == Colors.transparent) {
          color2DArray[i][j] = Color.fromARGB(255, 171, 171, 171);
          if (!colorOfLetter.containsKey(row[j])) {
            // Only set if not yet colored, to avoid overriding green
            colorOfLetter[row[j]] = Color.fromARGB(255, 171, 171, 171);
          }
        }
      }
    }
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
                        color: color2DArray[rowIndex][charIndex],
                        border: Border.all(
                            color: color2DArray[rowIndex][charIndex] ==
                                    Colors.transparent
                                ? Colors.grey
                                : color2DArray[rowIndex][charIndex],
                            width: 3)),
                    child: Center(
                        child: Text(char,
                            style: TextStyle(
                                fontSize: 20,
                                color: color2DArray[rowIndex][charIndex] ==
                                        Colors.transparent
                                    ? Colors.white
                                    : Colors.black))),
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
                        (100 *
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
