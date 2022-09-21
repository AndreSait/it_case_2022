import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedObstacle extends StatefulWidget {
  const AnimatedObstacle({super.key});

  @override
  State<AnimatedObstacle> createState() => _AnimatedObstacleState();
}

class _AnimatedObstacleState extends State<AnimatedObstacle> {
  late bool jump = false;
  OverlayEntry? entry;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => showOverlay());
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        jump = !jump;
      });
      print(jump);
    });
  }

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  Widget buildOverlay() => Material(
        color: Colors.red.withOpacity(0),
        elevation: 2,
        child: Container(
            color: Colors.red.withOpacity(0),
            height: 100,
            width: 500,
            child: Flexible(
              fit: FlexFit.tight,
              child: AnimatedContainer(
                color: Colors.red.withOpacity(0),
                duration: Duration(seconds: 1),
                alignment: jump
                    ? AlignmentDirectional.bottomStart
                    : AlignmentDirectional.topStart,
                child: Text("yoo"),
              ),
            )),
      );

  void showOverlay() {
    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    entry = OverlayEntry(
        builder: (context) => Positioned(
              // left: offset.dx,
              top: offset.dy + 180,
              // width: size.width,
              child: buildOverlay(),
            ));

    overlay.insert(entry!);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
