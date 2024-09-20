import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/meals_provider.dart';
import 'package:meals_app/screens/filters.dart';

const initialsFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier() : super(initialsFilters);

  void setFilter({required Filter filter, required bool val}) {
    state = {...state, filter: val};
  }

  void resetFilters() {
    state = initialsFilters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filtersProvider);

  final filteredMeals = meals.where((meal) {
    if (filters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
    if (filters[Filter.vegetarian]! && !meal.isVegetarian) return false;
    if (filters[Filter.vegan]! && !meal.isVegan) return false;
    if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
    return true;
  });
  return filteredMeals.toList();
});
