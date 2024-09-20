import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/provider/filters.provider.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widget/category_item.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widget/meal_card.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({
    super.key,
  });

  List<Meal> _getMealsByCategory(MealCategory category) {
    final meals = List.of(dummyMeals);
    final List<Meal> filteredMeals = [];
    for (int index = 0; index < meals.length; index++) {
      var isMatchCategory =
          meals[index].categories.any((cat) => cat == category.id);
      if (isMatchCategory) {
        filteredMeals.add(meals[index]);
      }
    }

    return filteredMeals;
  }

  List<Meal> _getFilteredMeals(
      MealCategory category, Map<Filter, bool> filters) {
    final categorizedMeals = _getMealsByCategory(category);
    final filteredMeals = categorizedMeals.where((meal) {
      if (filters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
      if (filters[Filter.vegetarian]! && !meal.isVegetarian) return false;
      if (filters[Filter.vegan]! && !meal.isVegan) return false;
      if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
      return true;
    });
    return filteredMeals.toList();
  }

  void _selectCategory(BuildContext context,
      {required MealCategory category, required filters}) {
    final filteredMeals = _getFilteredMeals(category, filters);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
            title: getCapitalizedText(category.title.name),
            meals: filteredMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = useProvider(ref, filtersProvider);
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
        ),
        itemCount: availableCategories.length,
        itemBuilder: (BuildContext context, int index) {
          return CategoryItem(
              category: availableCategories[index],
              onSelectCategory: () {
                _selectCategory(context,
                    category: availableCategories[index], filters: filters);
              });
        },
      ),
    );
  }
}
