import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

String getCapitalizedText(String text) {
  return text[0].toUpperCase() + text.substring(1);
}

class MealCard extends StatelessWidget {
  const MealCard({super.key, required this.onSelectMeal, required this.meal});
  final Meal meal;
  final void Function(BuildContext, Meal) onSelectMeal;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelectMeal(context, meal),
      borderRadius: BorderRadius.circular(10),
      splashColor: Theme.of(context).splashColor,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              width: double.infinity,
              height: 225,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: const Color.fromARGB(167, 0, 0, 0),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealMetaDataItem(
                          icon: Icons.leaderboard_outlined,
                          label: getCapitalizedText(meal.complexity.name),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MealMetaDataItem(
                          icon: Icons.watch_later_outlined,
                          label: '${meal.duration.toString()} Min',
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MealMetaDataItem(
                          icon: Icons.attach_money_outlined,
                          label: getCapitalizedText(meal.affordability.name),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealMetaDataItem extends StatelessWidget {
  const MealMetaDataItem(
      {required this.icon,
      this.color = Colors.white,
      required this.label,
      super.key});
  final Color color;
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 15,
            color: color,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 12),
          ),
        ]);
  }
}
