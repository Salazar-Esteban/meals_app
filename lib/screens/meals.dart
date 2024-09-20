import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/widget/meal_card.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });
  final String? title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(meals);
    Widget content = ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: meals.length,
        itemBuilder: (context, index) {
          return MealCard(onSelectMeal: _selectMeal, meal: meals[index]);
        });

    if (meals.isEmpty) {
      content = const Center(
        child: Text(
          ' No meals found ❗ ',
          style: TextStyle(color: Colors.black45, fontSize: 25),
        ),
      );
    }
    if (title == null) return content;

    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: content);
  }
}
