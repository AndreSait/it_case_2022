import 'package:flutter/material.dart';
import 'dart:async';

import 'package:it_case_2022/game_manager.dart';
import 'package:it_case_2022/widgets/game_components/jumping_game/number_of_clicks.dart';
import '../../../widgets/game_components/jumping_game/animated_obstacle_two.dart';

class RunningGraphics extends StatefulWidget {
  final GameManager gameManager;
  NumberOfClicks numberOfClicks;
  RunningGraphics(this.gameManager, this.numberOfClicks, {super.key});

  @override
  State<RunningGraphics> createState() => _RunningGraphicsState();
}

class _RunningGraphicsState extends State<RunningGraphics> {
  late bool jump = false;

  void startJumpTimer() {
    setState(() {
      jump = true;
    });
    Timer(Duration(seconds: 1), () {
      setState(() {
        jump = false;
      });
    });
  }

  int currentTick = 0;
  int numberOfJumps = 1;
  void startTicker() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        currentTick++;
      });
      if ((widget.numberOfClicks.clicks == 1 && numberOfJumps == 1) ||
          (widget.numberOfClicks.clicks == 2 && numberOfJumps == 2) ||
          (widget.numberOfClicks.clicks == 3 && numberOfJumps == 3) ||
          (widget.numberOfClicks.clicks == 4 && numberOfJumps == 4) ||
          (widget.numberOfClicks.clicks == 5 && numberOfJumps == 5) ||
          (widget.numberOfClicks.clicks == 6 && numberOfJumps == 6) ||
          (widget.numberOfClicks.clicks == 7 && numberOfJumps == 7) ||
          (widget.numberOfClicks.clicks == 8 && numberOfJumps == 8) ||
          (widget.numberOfClicks.clicks == 9 && numberOfJumps == 9) ||
          (widget.numberOfClicks.clicks == 10 && numberOfJumps == 10)) {
        if (currentTick > 60) {
          currentTick = 0;
        }
        startJumpTimer();
        numberOfJumps++;
      }
      // print(currentTick);
      if (currentTick > 100) {
        timer.cancel();
        widget.gameManager.endGame(context, 0);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTicker();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(children: [
          Flexible(
            flex: 1,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: jump ? Curves.easeOut : Curves.easeIn,
              padding: EdgeInsets.only(left: 20),
              alignment: jump
                  ? Alignment.topLeft
                  : Alignment.bottomLeft, // use aligment
              color: Colors.white,
              child: Image.asset("assets/images/running-man.gif",
                  height: 100, width: 100, fit: BoxFit.cover),
            ),
          ),
        ]),
        AnimatedObstacleTwo(),
      ],
    );
  }
}
