// cubit/todo_cubit.dart
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/bloc/todo_cubit/todo_state.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/repository/todo_repository.dart';
import 'package:flutter_todo_app/service_locator.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _repository;

  TodoCubit({required TodoRepository repository})
      : _repository = serviceLocator<TodoRepository>(),
        super(InitialState());

  // Fetch todos
  Future<void> getTodos() async {
    emit(TodosLoadingState());
    // Added timer to fake longer response time
    Timer(const Duration(milliseconds: 500), () async {
      try {
        List<Todo> todos = await _repository.getTodos();
        // Checking if we have todos, if so update only datetime, if not get todos and lastUpdated value
        emit(state is TodosLoadedState
            ? (state as TodosLoadedState).copyWith(lastUpdated: DateTime.now())
            : TodosLoadedState(todos, lastUpdated: DateTime.now()));
      } catch (e) {
        emit(TodosErrorState(e.toString()));
      }
    });
  }

  Future<void> addTodo(Todo todo) async {
    try {
      await _repository.addTodo(todo);
      getTodos();
    } catch (e) {
      emit(TodosErrorState(e.toString()));
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await _repository.updateTodo(todo);
      getTodos();
    } catch (e) {
      emit(TodosErrorState(e.toString()));
    }
  }

  Future<void> deleteTodo(String? id) async {
    try {
      await _repository.deleteTodo(id);
      getTodos();
    } catch (e) {
      emit(TodosErrorState(e.toString()));
    }
  }
}
