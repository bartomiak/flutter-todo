// cubit/todo_states.dart

import 'package:flutter_todo_app/models/todo.dart';

abstract class TodoState {}

class InitialState extends TodoState {}

class TodosLoadingState extends TodoState {}

class TodosLoadedState extends TodoState {
  final List<Todo> todos;

  TodosLoadedState(this.todos);
}

class TodosErrorState extends TodoState {
  final String errorMessage;

  TodosErrorState(this.errorMessage);
}
