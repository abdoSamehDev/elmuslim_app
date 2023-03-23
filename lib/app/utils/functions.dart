import 'package:flutter/services.dart';

Future<String> fetchDataFromJson(String jsonPath) async {
  String jsonString = await rootBundle.loadString(jsonPath);
  return jsonString;
}
