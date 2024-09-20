import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {required this.category, required this.onSelectCategory, super.key});
  final MealCategory category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    print(category.color);
    return InkWell(
      onTap: () => onSelectCategory(),
      borderRadius: BorderRadius.circular(10),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            category.color.withOpacity(.5),
            category.color.withOpacity(.9)
          ], begin: Alignment.bottomLeft, end: Alignment.topRight),
        ),
        child: Center(
          child: Text(
            category.title.name,
            style: const TextStyle(color: Color.fromARGB(255, 254, 254, 254)),
          ),
        ),
      ),
    );
  }
}
