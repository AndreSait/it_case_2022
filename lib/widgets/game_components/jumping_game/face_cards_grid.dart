import 'package:flutter/material.dart';
import "../../../models/person.dart";

import 'face_card.dart';

class FaceCardsGrid extends StatelessWidget {
  final List<Person> randomPersonList;
  final Function onPressed;
  FaceCardsGrid(
      {required this.randomPersonList, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.only(bottom: 25, left: 80, right: 80),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      children: randomPersonList.map((person) {
        return FaceCard(person: person, onPressed: onPressed);
      }).toList(),
    );
  }
}
