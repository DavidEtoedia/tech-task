import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/bloc/ingredients_bloc.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/widget/ingredient_list.dart';
import 'package:flutter_tech_task_master/presentation/widgets/text_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController date = TextEditingController();
  DateTime selectedDate = DateTime.now();

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
                  date.text = onDate(picked);
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
                } else if (state.errorMessage!.isNotEmpty) {
                  return Text(state.errorMessage.toString());
                } else if (state.result.isNotEmpty) {
                  return IngredientGrid(
                    result: state.result,
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

  String onDate(DateTime date) {
    DateTime originalDateTime = DateTime.parse(date.toIso8601String());
    return originalDateTime.toFormattedDateString();
  }
}

extension DateTimeExtensions on DateTime {
  String toFormattedDateString() {
    return "$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}";
  }
}
