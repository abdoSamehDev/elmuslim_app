import 'dart:convert';

import 'package:flutter/services.dart';

void fetchDataFromJson(String jsonPath) async {
  String jsonString = await rootBundle.loadString(jsonPath);
  var data = jsonDecode(jsonString);
  return data;
}
