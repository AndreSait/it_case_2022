import 'package:shared_preferences/shared_preferences.dart';

class HighScoreManager {
  String highScoreKey = "highScore";

  Future<int> getHighScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int highScore = prefs.getInt(highScoreKey) ?? 0;
    return highScore;
  }

  Future<void> setHighScoreIfBigger(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int highScore = prefs.getInt(highScoreKey) ?? 0;
    if (score > highScore) {
      prefs.setInt(highScoreKey, score);
    }
  }
}
