import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/provider/meals_provider.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widget/gluten_chip.dart';
import 'package:meals_app/widget/meal_card.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({required this.meal, super.key});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGluterFreeText = meal.isGlutenFree ? 'Gluten free' : '';
    final isVegetarianText = meal.isVegetarian ? 'Vegetarian' : '';
    final isVeganText = meal.isVegan ? 'Vegan' : '';
    final List<Meal> favorites = useProvider(ref, favoriteMealsProvider);
    final bool isFavorite = favorites.contains(meal);
    void _showInfoMessage(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: const Color.fromARGB(255, 255, 64, 74),
          hitTestBehavior: HitTestBehavior.translucent,
          content: Text(message)));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                final wasAdded = ref
                    .read(favoriteMealsProvider.notifier)
                    .addToFavorite(meal);
                _showInfoMessage(wasAdded
                    ? 'Meal added to favorites'
                    : 'Meal removed from favorites');
              },
              icon: Icon(
                !isFavorite
                    ? Icons.star_border_outlined
                    : Icons.remove_circle_outline_sharp,
                color: Color.fromARGB(255, 241, 75, 130),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  MealMetaDataItem(
                      color: Colors.black45,
                      icon: Icons.watch_later_outlined,
                      label: '${meal.duration} min'),
                  const SizedBox(
                    width: 10,
                  ),
                  MealMetaDataItem(
                    color: Colors.black45,
                    icon: Icons.leaderboard_outlined,
                    label: getCapitalizedText(meal.complexity.name),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MealMetaDataItem(
                    color: Colors.black45,
                    icon: Icons.attach_money_outlined,
                    label: getCapitalizedText(meal.affordability.name),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    meal.isGlutenFree
                        ? MealChip(isGluterFreeText, glutenColor)
                        : Text(''),
                    const SizedBox(
                      width: 10,
                    ),
                    meal.isVegetarian
                        ? MealChip(isVegetarianText, vegetarianColor)
                        : Text(''),
                    const SizedBox(
                      width: 10,
                    ),
                    meal.isVegan ? MealChip(isVeganText, veganColor) : Text(''),
                  ]),
            ),
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            // Wrap ListView.builder in Expanded
            Expanded(
              child: ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (context, idx) {
                  return SizedBox(
                    height: 40,
                    child: Row(children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: const Color.fromARGB(255, 36, 95, 234),
                        ),
                        alignment: Alignment.center,
                        width: 25,
                        height: 25,
                        child: Text(
                          '${idx + 1}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        meal.ingredients[idx],
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      )
                    ]),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Steps',
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            // Wrap ListView.builder in Expanded
            Expanded(
              child: ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (context, idx) {
                  return SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromARGB(255, 36, 95, 234),
                          ),
                          alignment: Alignment.center,
                          width: 25,
                          height: 25,
                          child: Text(
                            '${idx + 1}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            meal.steps[idx],
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
