import 'package:flutter/material.dart';
import 'package:it_case_2022/game_manager.dart';
import 'package:it_case_2022/widgets/games/namle_game.dart';
import './widgets/start_screen.dart';
import "../utils/http_methods.dart";
import './models/person.dart';

import './widgets/games/memory_game.dart';
import './widgets/games/jumping_game.dart';
import './widgets/high_scores.dart';
import "./widgets/game_over_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    fetchAllPersons();
  }

  List<Person>? allPersons;
  GameManager gameManager = GameManager();

  Future<void> fetchAllPersons() async {
    List<Person> newAllPersons = [];

    try {
      newAllPersons = await fetchColleagues();
    } catch (ex, stacktrace) {
      print("Exception $ex");
      print("StackTrace $stacktrace");
    }

    // List<String> names = newAllPersons.map((element) => element.name).toList();

    setState(() {
      allPersons = newAllPersons;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          canvasColor: Color.fromARGB(255, 228, 227, 194),
          fontFamily: "Railway",
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.yellow,
            accentColor: Colors.amber,
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                headline1: TextStyle(
                  fontSize: 50,
                  fontFamily: "Railway",
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              )),
      home: allPersons != null
          ? StartScreen(gameManager: gameManager, allPersons: allPersons)
          : Center(child: CircularProgressIndicator()),
      routes: {
        MemoryGame.routeName: (ctx) => MemoryGame(gameManager),
        NamleGame.routeName: (ctx) => NamleGame(gameManager, allPersons!),
        JumpingGame.routeName: (ctx) => JumpingGame(gameManager, allPersons!),
        GameOverScreen.routeName: (ctx) => GameOverScreen(gameManager),
        HighScores.routeName: (ctx) => HighScores(),
      },
    );
  }
}
