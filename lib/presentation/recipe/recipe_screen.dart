import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task_master/presentation/recipe/bloc/recipe_bloc.dart';
import 'package:flutter_tech_task_master/presentation/recipe/widget/recipe_grid.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Recipe",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<RecipeBloc, RecipeState>(builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.result.isNotEmpty) {
                  return RecipeGrid(
                    result: state.result,
                  );
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
