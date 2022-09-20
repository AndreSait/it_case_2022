import "package:flutter/material.dart";

import "../../../models/person.dart";

import 'package:cached_network_image/cached_network_image.dart';

class FaceCard extends StatelessWidget {
  final Person person;
  final Function onPressed;
  const FaceCard({required this.person, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkWell(
          onTap: () => {onPressed(person.index)},
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
                child: CachedNetworkImage(
                  imageUrl: person.imageUrl,
                  fit: BoxFit.cover,
                ),
              )),
        ));
  }
}
