import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Categories {
  italian,
  german,
  japan,
  chinise,
  venezuelan,
  vegetarian,
  vegan,
  fried,
  quickEasy
}

class MealCategory {
  const MealCategory(
      {required this.title, required this.color, required this.id});
  final String id;
  final Categories title;
  final Color color;
}
