import 'package:flutter/material.dart';
import 'package:it_case_2022/widgets/big_button.dart';
import 'package:share_plus/share_plus.dart';
import "../game_manager.dart";

class GameOverScreen extends StatelessWidget {
  static String routeName = "game-over-screen";
  final GameManager gameManager;
  const GameOverScreen(this.gameManager, {super.key});

  void shareScore() {
    Share.share(
        "I scored ${gameManager.totalScore} points in navneVerket - IT Case 2022!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Over"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "Total score: ${gameManager.totalScore}",
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: BigButton("Share with your colleages", (context) {
              shareScore();
            }),
          )
        ],
      ),
    );
  }
}
