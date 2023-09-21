import 'package:flutter/material.dart';
import 'package:flutter_tech_task_master/domain/model/recipe_model.dart';

class RecipeGrid extends StatelessWidget {
  const RecipeGrid({required this.result, super.key});

  final List<RecipeModel> result;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      physics:
          const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 7.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1),
      itemCount: result.length,
      itemBuilder: (context, index) {
        var food = result[index];
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
          ),
          child: Column(
            children: [
              Text(food.title.toString()),
              const SizedBox(
                height: 20,
              ),
              Column(
                  children: List.generate(food.ingredients!.length,
                      (index) => Text(food.ingredients![index])))
            ],
          ),
        );
      },
    ));
  }
}
