import "package:flutter/material.dart";

class FlipCard extends StatelessWidget {
  final String? image;
  final String? name;

  const FlipCard({this.image, this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: Card(
        elevation: 10,
        child: Center(child: Text("Card")),
      ),
    );
  }
}
