import 'package:flutter/material.dart';
import 'package:it_case_2022/widgets/games/wordle_game/namle.dart';
import './widgets/start_screen.dart';
import "../utils/http_methods.dart";
import './models/person.dart';

import './widgets/games/memory_game.dart';
import './widgets/games/jumping_game.dart';
import './widgets/high_scores.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  List<Person>? allPersons;

  Future<void> fetchAllPersons() async {
    List<Person> newAllPersons = [];

    try {
      newAllPersons = await fetchColleagues();
    } catch (ex, stacktrace) {
      print("Exception $ex");
      print("StackTrace $stacktrace");
    }

    List<String> names = newAllPersons.map((element) => element.name).toList();

    print("Got the following names: $names");
    setState(() {
      allPersons = newAllPersons;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      fetchAllPersons();
    }
    index++;
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
      home: StartScreen(allPersons: allPersons),
      routes: {
        MemoryGame.routeName: (ctx) => MemoryGame(),
        NamlePage.routeName: (ctx) => NamlePage(),
        JumpingGame.routeName: (ctx) => JumpingGame(
              personList: allPersons!,
            ),
        HighScores.routeName: (ctx) => HighScores(),
      },
    );
  }
}
