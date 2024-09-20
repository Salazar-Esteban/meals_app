import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/provider/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widget/main_drawer.dart';

const addedText = "Meal added to favorites sucessfully !";
const removedText = "Meal removed from favorites";

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _currentPageIdx = 0;

  void _selectDrawerScreen(DrawerScreenIdentifiers identifier) {
    Navigator.of(context).pop();
    if (identifier == DrawerScreenIdentifiers.filters) {
      Navigator.push<Map<Filter, bool>>(context,
          MaterialPageRoute(builder: (context) {
        return FiltersScreen();
      }));
    }
  }

  void _selectPage(int idx) {
    setState(() {
      _currentPageIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> favoriteMeals = useProvider(ref, favoriteMealsProvider);

    final currentPageActive = {
      0: {
        "title": 'Categories',
        "body": CategoriesScreen(),
      },
      1: {
        "title": 'Your Favorites',
        "body": MealsScreen(
          meals: favoriteMeals,
        )
      },
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(currentPageActive[_currentPageIdx]!['title'] as String),
      ),
      drawer: MainDrawer(selectScreen: _selectDrawerScreen),
      body: currentPageActive[_currentPageIdx]!['body'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _currentPageIdx,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.set_meal_outlined,
                  size: 25,
                ),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.star_border_outlined,
                  size: 25,
                ),
                label: 'Favorites'),
          ]),
    );
  }
}

dynamic useProvider(WidgetRef ref, StateNotifierProvider provider) {
  return ref.watch(provider);
}
