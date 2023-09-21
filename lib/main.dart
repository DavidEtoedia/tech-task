import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tech_task_master/presentation/helper/navigator.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/bloc/ingredients_bloc.dart';
import 'package:flutter_tech_task_master/presentation/ingredent/ingredient_view.dart';
import 'package:flutter_tech_task_master/presentation/recipe/bloc/recipe_bloc.dart';

import 'core/di/injector.dart';

void main() async {
  await initializeCore();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<IngredientsBloc>(
              create: (_) =>
                  IngredientsBloc(inject())..add(const SelectDateEvent())),
        ],
        child: MaterialApp(
          title: 'tech-task',
          navigatorKey: navigator.key,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
        ));
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('${bloc.runtimeType} $change');
  }
}
