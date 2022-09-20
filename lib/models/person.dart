import 'package:flutter/material.dart';

class Person {
  int? index;
  final String name;
  final String imageUrl;
  final String? gender;
  Color color;

  Person({
    this.index,
    required this.name,
    required this.imageUrl,
    this.gender,
    this.color = Colors.grey,
  });

  Person.fromJson(Map<String, dynamic> json)
      : index = null,
        name = json['Name'],
        imageUrl = json['Image'],
        gender = json['Gender'],
        color = Colors.grey;

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Image': imageUrl,
        'Gender': gender,
      };
}
