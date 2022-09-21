import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:it_case_2022/models/person.dart';
import 'package:it_case_2022/widgets/games/memory_game.dart';

class FlipCard extends StatelessWidget {
  final Key? key;
  final CardInfo cardInfo;
  final Function(CardInfo person) callback;

  FlipCard(this.cardInfo, this.callback, {this.key}) : super(key: key);

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: () {
        callback(cardInfo);
      },
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        child: !cardInfo.isFlipped ? _buildFront() : _buildRear(),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(!cardInfo.isFlipped) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _buildFront() {
    return Card(
      key: ValueKey(true),
      elevation: 10,
      color: Color.fromARGB(255, 209, 201, 201),
      child: Center(
        child: CachedNetworkImage(
            imageUrl:
                "https://cdn.sanity.io/images/ndtelfg5/production/9e304004f37b0dc576283e1894deab9478eaf242-107x146.png?rect=0,20,107,107&w=50&h=50&auto=format"),
      ),
    );
  }

  Widget _buildRear() {
    return cardInfo.showImage ? _buildImage() : _buildText();
  }

  Widget image(String url) {
    return SizedBox(
      width: 250,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              placeholder: (ctx, str) => SizedBox.expand(
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
          )),
    );
  }

  _buildImage() {
    return Card(
      key: ValueKey(false),
      elevation: 10,
      child: Center(child: image(cardInfo.person.imageUrl)),
    );
  }

  _buildText() {
    return Card(
      key: ValueKey(false),
      elevation: 10,
      child: Center(
          child: Text(
        cardInfo.person.name,
        style: TextStyle(fontSize: 20, color: Colors.black38),
        textAlign: TextAlign.center,
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildFlipAnimation();
  }
}
