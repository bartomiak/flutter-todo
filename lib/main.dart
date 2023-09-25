import 'package:flutter/material.dart';
import 'package:flutter_todo_app/api/app_rest_client.dart';
import 'package:flutter_todo_app/bloc/todo_cubit/todo_cubit.dart';
import 'package:flutter_todo_app/pages/todo_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/repository/todo_repository.dart';
import 'package:flutter_todo_app/service_locator.dart';

void main() {
  setupServicesLocator(); // Don't forget to call this first to initialize GetIt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(
          repository: TodoRepository(
              client:
                  AppRestClient())), // Here we fetch TodoRepository using GetIt
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: const TodoPage(),
      ),
    );
  }
}
