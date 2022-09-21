import "package:flutter/material.dart";
import 'package:it_case_2022/highscore_manager.dart';
import "dart:math";

import './widgets/games/namle_game.dart';
import './widgets/games/memory_game.dart';
import './widgets/games/jumping_game.dart';
import "./widgets/game_over_screen.dart";

class GameManager {
  int currentRoundIndex = 0;
  int totalScore = 0;
  List<String> gameRoutes = [
    NamleGame.routeName,
    MemoryGame.routeName,
    JumpingGame.routeName,
  ];
  List<String> lastTenGames = [];

  void startNewGame(BuildContext ctx, routeName) {
    totalScore = 0;
    lastTenGames = [routeName];

    Navigator.of(ctx).pushNamed(
      routeName, /*arguments: {"id": id, "title": title}*/
    );
  }

  void nextGame(BuildContext ctx, int score) {
    totalScore += score;

    int randomIndex = 0;
    var random = Random();
    void newRandomIndex() {
      randomIndex = random.nextInt(gameRoutes.length);
    }

    int gamesPlayed = lastTenGames.length;
    while (gameRoutes[randomIndex] == lastTenGames.last) {
      newRandomIndex();
    }
    int few = 4; // The number of last few checked for pseudo-randomness
    if (gamesPlayed > few) {
      Set<String> lastFewTypes = {};
      int numberOfVariationsForLastFew() {
        for (int i = 1; i < 5; i++) {
          lastFewTypes.add(lastTenGames[lastTenGames.length - i]);
        }
        return lastFewTypes.length;
      }

      if (numberOfVariationsForLastFew() < 3) {
        while (lastFewTypes.contains(gameRoutes[randomIndex])) {
          newRandomIndex();
        }
      }
    }
    String nextGameRoute = gameRoutes[randomIndex];
    lastTenGames.add(nextGameRoute);
    if (totalScore > 10000) {
      endGame(ctx, totalScore);
    } else {
      Navigator.of(ctx).pushReplacementNamed(nextGameRoute);
    }
  }

  void endGame(BuildContext ctx, int score) {
    HighScoreManager highScoreManager = HighScoreManager();
    highScoreManager.setHighScoreIfBigger(score);

    Navigator.of(ctx).pushReplacementNamed(GameOverScreen.routeName);
  }
}
