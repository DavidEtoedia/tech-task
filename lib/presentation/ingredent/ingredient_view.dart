import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task_master/core/di/injector.dart';
import 'package:flutter_tech_task_master/presentation/helper/navigator.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/bloc/ingredients_bloc.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/widget/ingredient_card.dart';
import 'package:flutter_tech_task_master/presentation/recipe/bloc/recipe_bloc.dart';
import 'package:flutter_tech_task_master/presentation/recipe/recipe_screen.dart';
import 'package:flutter_tech_task_master/presentation/widgets/text_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController date = TextEditingController();
  final recipe = RecipeBloc(inject());
  DateTime selectedDate = DateTime.now();

  final List<String> selected = [];

  void add(String value) {
    if (!selected.contains(value) && (selected.length < 2)) {
      selected.add(value);
      setState(() {});
    } else {
      selected.remove(value);
      setState(() {});
    }
  }

  void removeAll() {
    selected.clear();
    setState(() {});
  }

  @override
  void dispose() {
    date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormInput(
              labelText: "Enter launch date",
              controller: date,
              readOnly: true,
              suffixIcon: IconButton(
                  onPressed: () {
                    if (date.text.isEmpty) return;
                    setState(() => date.text = "");
                    if (mounted) {
                      BlocProvider.of<IngredientsBloc>(context)
                          .add(SelectDateEvent.datePressed(data: ""));
                    }
                  },
                  icon: const Icon(Icons.cancel)),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );

                if (picked != null) {
                  DateTime originalDateTime =
                      DateTime.parse(picked.toIso8601String());

                  String convertedDate =
                      "${originalDateTime.year}-${originalDateTime.month.toString().padLeft(2, '0')}-${originalDateTime.day.toString().padLeft(2, '0')}";
                  date.text = convertedDate;

                  if (mounted) {
                    BlocProvider.of<IngredientsBloc>(context)
                        .add(SelectDateEvent.datePressed(data: date.text));
                  }
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<IngredientsBloc, IngredientState>(
              listener: (c, s) {},
              builder: (context, state) {
                if (state.isLoading) {
                  return const CircularProgressIndicator();
                } else if (state.result.isNotEmpty) {
                  return Expanded(
                    key: const ValueKey(
                        "Select only 2 ingredients and get their recipes"),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                "Select only 2 ingredients and get their recipes",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  if (selected.length < 2) return;

                                  recipe.add(RecipeEvent.getRecipe(
                                      ingredentA: selected[0],
                                      ingredentB: selected[1]));

                                  removeAll();
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 7.0,
                                  crossAxisSpacing: 10.0,
                                  childAspectRatio: 2),
                          itemCount: state.result.length,
                          itemBuilder: (context, index) {
                            var food = state.result[index];
                            return IngredientCard(
                              food: food,
                              color: selected.contains(food.title.toString())
                                  ? Colors.blue
                                  : Colors.transparent,
                              onTap: () => add(food.title.toString()),
                            );
                          },
                        )),
                      ],
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    ));
  }
}
