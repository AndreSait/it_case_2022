import 'package:flutter/material.dart';
import 'widgets/start_screen.dart';
import "./utils/http_methods.dart";

void main() {
  runApp(const MyApp());
  print(fetchColleagues());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: StartScreen(),
      routes: {
        //todo
      },
    );
  }
}
