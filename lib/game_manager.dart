import "package:flutter/material.dart";

import './widgets/games/namle_game.dart';
import './widgets/games/memory_game.dart';
import './widgets/games/jumping_game.dart';

class GameManager {
  void startSpecificGame(BuildContext ctx, routeName) {
    Navigator.of(ctx).pushNamed(
      routeName, /*arguments: {"id": id, "title": title}*/
    );
  }

  void nextGame(BuildContext ctx, int score) {
    print(score);
    Navigator.of(ctx).pushReplacementNamed(NamleGame.routeName);
  }
}
