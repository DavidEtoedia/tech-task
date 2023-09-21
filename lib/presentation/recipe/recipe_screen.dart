import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task_master/presentation/recipe/bloc/recipe_bloc.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Recipe",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.result.isNotEmpty) {
                  return Expanded(
                      child: GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 7.0,
                            crossAxisSpacing: 10.0,
                            childAspectRatio: 1),
                    itemCount: state.result.length,
                    itemBuilder: (context, index) {
                      var food = state.result[index];
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
                                children: List.generate(
                                    food.ingredients!.length,
                                    (index) => Text(food.ingredients![index])))
                          ],
                        ),
                      );
                    },
                  ));
                }
                return const CircularProgressIndicator();
              })
            ],
          ),
        ),
      ),
    );
  }
}
