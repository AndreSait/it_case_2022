import 'package:flutter/material.dart';
import "../game_manager.dart";

class GameOverScreen extends StatelessWidget {
  static String routeName = "game-over-screen";
  final GameManager gameManager;
  const GameOverScreen(this.gameManager, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("${gameManager.totalScore}"),
    );
  }
}
