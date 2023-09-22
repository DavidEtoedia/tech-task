import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task_master/core/di/injector.dart';
import 'package:flutter_tech_task_master/domain/model/ingredients.dart';
import 'package:flutter_tech_task_master/presentation/helper/navigator.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/widget/ingredient_card.dart';
import 'package:flutter_tech_task_master/presentation/recipe/bloc/recipe_bloc.dart';
import 'package:flutter_tech_task_master/presentation/recipe/recipe_screen.dart';

class IngredientGrid extends StatefulWidget {
  const IngredientGrid({required this.result, super.key});

  final List<Ingredients> result;

  @override
  State<IngredientGrid> createState() => _IngredientGridState();
}

class _IngredientGridState extends State<IngredientGrid> {
  final recipe = RecipeBloc(inject());
  final List<String> selected = [];

  void addIngrdients(String value) {
    if (!selected.contains(value) && (selected.length < 2)) {
      selected.add(value);
      setState(() {});
    } else {
      selected.remove(value);
      setState(() {});
    }
  }

  void clearAllSelectedIngrdients() {
    selected.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: const ValueKey("Select only 2 ingredients and get their recipes"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Select only 2 ingredients and get their recipes",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              TextButton(
                  onPressed: () {
                    if (selected.length < 2) return;
                    recipe.add(RecipeEvent.getRecipe(
                        ingredentA: selected[0], ingredentB: selected[1]));

                    clearAllSelectedIngrdients();

                    context.navigate(BlocProvider.value(
                      value: recipe,
                      child: const RecipeScreen(),
                    ));
                  },
                  child: const Text(
                    "Get Recipe",
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 7.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2),
            itemCount: widget.result.length,
            itemBuilder: (context, index) {
              var food = widget.result[index];
              return IngredientCard(
                food: food,
                color: selected.contains(food.title.toString())
                    ? Colors.blue
                    : Colors.transparent,
                onTap: () => addIngrdients(food.title.toString()),
              );
            },
          )),
        ],
      ),
    );
  }
}
