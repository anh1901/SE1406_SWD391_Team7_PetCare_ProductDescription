import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:petcare/models/post_model.dart';

Future<String> _loadPostAsset() async {
  return await rootBundle.loadString('assets/posts.json');
}

Future loadPost() async {
  String jsonPost = await _loadPostAsset();
  final jsonResponse = json.decode(jsonPost);
  return new PostList.fromJson(jsonResponse);
}
