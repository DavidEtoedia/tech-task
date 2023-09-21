import 'package:flutter/material.dart';
import 'package:flutter_tech_task_master/domain/model/ingredients.dart';

class IngredientCard extends StatelessWidget {
  final Function()? onTap;
  final Ingredients food;
  final Color color;
  const IngredientCard(
      {this.onTap, required this.food, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            border: Border.all(width: 1.5, color: color)),
        child: Column(
          children: [
            Text(food.title.toString()),
            const Spacer(),
            Text(
              food.useby.toString(),
            )
          ],
        ),
      ),
    );
  }
}
