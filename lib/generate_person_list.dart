import 'package:flutter/material.dart';
import "dart:math";

import "./models/person.dart";

List<Person> generatePersonList(List<Person> personList, int numberOfPeople) {
  const List<Color> colorList = [
    Colors.purple,
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.blue,
    Colors.green,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.pink,
    Colors.teal,
  ];

  if (numberOfPeople < 1 || numberOfPeople > personList.length) {
    throw ArgumentError("numberOfPeople out of bounds", "InvalidArgument");
  } else {
    var randomGenerator = Random();
    int generateRandomIndex() {
      return randomGenerator.nextInt(personList.length);
    }

    List<int> indexList = [];
    int randomIndex;
    while (indexList.length < numberOfPeople) {
      randomIndex = generateRandomIndex();
      if (!indexList.contains(randomIndex)) {
        indexList.add(randomIndex);
      }
    }
    List<Person> randomPersonList = [];
    for (int index in indexList) {
      Person newPerson = personList[index];
      newPerson.index = index;

      if (index < colorList.length) {
        newPerson.color = colorList[index];
      } else {
        newPerson.color = colorList[index % colorList.length];
      }
      randomPersonList.add(newPerson);
    }
    return randomPersonList;
  }
}
