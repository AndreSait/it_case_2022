import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/person.dart';

const String _apiToken =
    "mKJCxaVuYh7BKL1BPlF6IKnwpWV7OILSBBLftRLa4XRd8m9CZWtBpg==";

Future<List<Person>> fetchColleagues() async {
  dynamic response = await http.get(Uri.parse(
      'https://employee-image-provider.azurewebsites.net/api/fetchallemployeeimageurls?code=$_apiToken'));

  List<dynamic> colleaguesJson = jsonDecode(response.body);

  return colleaguesJson.map((e) => Person.fromJson(e)).toList();
}
