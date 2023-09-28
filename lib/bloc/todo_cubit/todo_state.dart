// cubit/todo_states.dart

import 'package:equatable/equatable.dart';
import 'package:flutter_todo_app/models/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class InitialState extends TodoState {
  @override
  List<Object> get props => [];
}

class TodosLoadingState extends TodoState {
  @override
  List<Object> get props => [];
}

class TodosLoadedState extends TodoState {
  final DateTime? lastUpdated;
  final List<Todo> todos;

  const TodosLoadedState(this.todos, {this.lastUpdated});

  @override
  List<Object?> get props => [todos, lastUpdated];

  // 
  TodosLoadedState copyWith({
    List<Todo>? todos,
    DateTime? lastUpdated,
  }) {
    return TodosLoadedState(
      todos ?? this.todos,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

class TodosErrorState extends TodoState {
  final String errorMessage;

  const TodosErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
