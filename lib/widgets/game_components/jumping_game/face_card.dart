import "package:flutter/material.dart";

import "../../../models/person.dart";

import 'package:cached_network_image/cached_network_image.dart';
import "number_of_clicks.dart";

class FaceCard extends StatelessWidget {
  final Person person;
  final Function onPressed;
  final Function generateNewPersonList;
  final NumberOfClicks numberOfClicks;
  final int correctPersonIndex;
  const FaceCard(
      {required this.person,
      required this.onPressed,
      required this.generateNewPersonList,
      required this.numberOfClicks,
      required this.correctPersonIndex,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkWell(
          onTap: (person.index == correctPersonIndex)
              ? () {
                  onPressed(person.index);
                  numberOfClicks.addClick();
                  generateNewPersonList();
                }
              : () => generateNewPersonList(),
          splashColor: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50),
          child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    person.color.withOpacity(0.5),
                    person.color,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 243, 243, 243),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: person.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
        ));
  }
}
