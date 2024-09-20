import 'package:flutter/material.dart';

const glutenColor = Colors.amber;
const vegetarianColor = Color.fromARGB(255, 47, 199, 125);
const veganColor = Colors.pink;

class MealChip extends StatelessWidget {
  const MealChip(this.text, this.color, {super.key});
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
