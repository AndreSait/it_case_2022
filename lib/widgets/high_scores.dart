import 'package:flutter/material.dart';

class HighScores extends StatelessWidget {
  static const routeName = "high-scores";
  const HighScores({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HIGH SCORES",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Here are the high scores"),
          ],
        ),
      ),
    );
  }
}
