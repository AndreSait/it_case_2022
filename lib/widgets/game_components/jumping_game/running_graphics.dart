import 'package:flutter/material.dart';
import 'dart:async';

class RunningGraphics extends StatefulWidget {
  const RunningGraphics({super.key});

  @override
  State<RunningGraphics> createState() => _RunningGraphicsState();
}

class _RunningGraphicsState extends State<RunningGraphics> {
  late bool jump = false;
  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        jump = !jump;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: jump ? Curves.easeOut : Curves.easeIn,
      padding: EdgeInsets.only(left: 20),
      alignment:
          jump ? Alignment.topLeft : Alignment.bottomLeft, // use aligment
      color: Colors.white,
      child: Image.asset("assets/images/running-man.gif",
          height: 100, width: 100, fit: BoxFit.cover),
    );
  }
}
