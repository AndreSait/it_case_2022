import 'dart:math';

import "package:flutter/material.dart";

class ScoreHelper extends StatefulWidget {
  const ScoreHelper({super.key});

  @override
  State<ScoreHelper> createState() => _ScoreHelperState();
}

class _ScoreHelperState extends State<ScoreHelper> {
  static var current_round = 0;
  static var current_score = 0;
  static var lastPlayed = {
    "jumping-game": 0,
    "memory-game": 0,
    "wordle-game": 0,
  };

  @override
  Widget build(BuildContext context) {
    // function select next game
    String nextGame() {
      // if first round select random game
      if (current_round == 0) {
        var random = Random();
        var game = random.nextInt(3);
        current_round++;
        if (game == 0) {
          lastPlayed["jumping-game"] = current_round;
          return "jumping-game";
        } else if (game == 1) {
          lastPlayed["memory-game"] = current_round;
          return "memory-game";
        } else {
          lastPlayed["wordle-game"] = current_round;
          return "wordle-game";
        }
      } else {
        // for game in lastPlayed check if game is played in last 5 rounds
        // if not select game
        // else select random game
        var previous_game = "";
        for (var game in lastPlayed.keys) {
          if (current_round - lastPlayed[game]! > 5) {
            current_round++;
            lastPlayed[game] = current_round;
            return game;
          }
          if (lastPlayed[game] == current_round) {
            previous_game = game;
          }
        }
        var random = Random();
        var gameNum = random.nextInt(2);

        if (gameNum == 0 && previous_game != "jumping-game") {
          current_round++;
          lastPlayed["jumping-game"] = current_round;
          return "jumping-game";
        } else if (gameNum == 1 && previous_game != "memory-game") {
          current_round++;
          lastPlayed["memory-game"] = current_round;
          return "memory-game";
        } else if (previous_game != "wordle-game") {
          current_round++;
          lastPlayed["wordle-game"] = current_round;
          return "wordle-game";
        } else {
          current_round++;
          lastPlayed["jumping-game"] = current_round;
          return "jumping-game";
        }
      }
    }

    String game_over(int score) {
      current_score += score;
      return nextGame();
    }

    // show a button to play game and display current score and current game
    
  }
}