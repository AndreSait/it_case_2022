import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedObstacleTwo extends StatefulWidget {
  const AnimatedObstacleTwo({super.key});

  @override
  State<AnimatedObstacleTwo> createState() => _AnimatedObstacleTwoState();
}

class _AnimatedObstacleTwoState extends State<AnimatedObstacleTwo> {
  late bool jump = false;
  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        jump = !jump;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AnimatedContainer(
        duration: Duration(seconds: 2),
        alignment: jump ? Alignment(2.1, 1) : Alignment(-2.1, 1),
        child: Image.asset("assets/images/computer-desk.png",
            height: jump ? 0 : 70, width: 70, fit: BoxFit.cover),
      ),
    );
  }
}
