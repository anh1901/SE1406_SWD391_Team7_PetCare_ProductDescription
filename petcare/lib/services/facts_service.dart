import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:petcare/models/fact_model.dart';

Future<String> _loadFactAsset() async {
  return await rootBundle.loadString('assets/facts.json');
}

Future loadFact() async {
  String jsonFact = await _loadFactAsset();
  final jsonResponse = json.decode(jsonFact);
  return new FactList.fromJson(jsonResponse);
}
