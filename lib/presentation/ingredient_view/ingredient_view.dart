import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task_master/core/di/injector.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/bloc/ingredients_bloc.dart';
import 'package:flutter_tech_task_master/presentation/widgets/text_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController date = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final event = IngredientsBloc(inject());
  @override
  void initState() {
    super.initState();
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
            BlocBuilder<IngredientsBloc, IngredientState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const CircularProgressIndicator();
                } else if (state.result.isNotEmpty) {
                  return Expanded(
                      child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    itemCount: state.result.length,
                    itemBuilder: (context, index) {
                      var food = state.result[index];
                      return Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.grey.shade300,
                        child: Row(
                          children: [
                            Text(food.title.toString()),
                            const Spacer(),
                            Text(
                              food.useby.toString(),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  ));
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
