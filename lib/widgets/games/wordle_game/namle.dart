import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'keyboard.dart';

class NamlePage extends StatefulWidget {
  static const String routeName = "namle";

  @override
  State<NamlePage> createState() => _NamlePageState();
}

class _NamlePageState extends State<NamlePage> {
  String name = "Peter".toUpperCase();

  final int _maxTries = 5;

  String guess = "";
  Map<String, Color> colorOfLetter = {};

  List<String> previousGuessArray = ["PETEA", "PETES"];

  bool testAttempt() {
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
          bool success = testAttempt();
          if (success) {
            print("Name guessed after ${previousGuessArray.length} tries");
          } else if (previousGuessArray.length > _maxTries) {
            print("Game over");
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

  "Peter"

  "Peter".remove("e")

  Color getColorOfChar(String c, int rowIndex, int charIndex) {
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
    int _gridWidthCount = name.length;
    double viewPortWidth = MediaQuery.of(context).size.width;
    double calculatedWidth = 50.0 * _gridWidthCount;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Namle'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: image(),
            ),
            // Gridview for guessing
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(
                      maxWidth: min(calculatedWidth, viewPortWidth)),
                  child: GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _gridWidthCount,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 4),
                    children:
                        List.generate(_gridWidthCount * _maxTries, (index) {
                      int rowIndex = index ~/ _gridWidthCount;
                      int charIndex = index % _gridWidthCount;
                      var char = getCharacter(rowIndex, charIndex);
                      return Container(
                        decoration: BoxDecoration(
                            color: getColorOfChar(char, rowIndex, charIndex),
                            border: Border.all(color: Colors.grey, width: 3)),
                        child: Center(
                            child: Text(char,
                                style: const TextStyle(fontSize: 20))),
                      );
                    }),
                  ),
                ),
              ],
            ),
            Keyboard(keyBoardClicked, colorOfLetter),
          ],
        ));
  }

  Widget image() {
    return Container(
      width: 250,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/400/300',
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
