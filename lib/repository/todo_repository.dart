// Import the necessary packages
import 'package:flutter_todo_app/api/app_rest_client.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/service_locator.dart';

class TodoRepository {
  final AppRestClient _client;

  // Constructor: We're injecting our Dio API client here
  TodoRepository({required AppRestClient client})
      : _client = serviceLocator<AppRestClient>();

  // READ: Fetch all todos
  Future<List<Todo>> getTodos() async {
    try {
      final response = await _client.getTodos();
      final List<dynamic> rawData = response.data;
      return rawData.map((e) => Todo.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // CREATE: Add a new todo
  Future<Todo> addTodo(Todo todo) async {
    try {
      final response = await _client.addTodo(todo.toJson());
      return Todo.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // UPDATE: Update a specific todo
  Future<Todo> updateTodo(Todo todo) async {
    try {
      final response = await _client.updateTodo(todo.id, todo.toJson());
      return Todo.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  // DELETE: Delete a specific todo
  Future<void> deleteTodo(String? id) async {
    try {
      await _client.deleteTodo(id);
    } catch (e) {
      rethrow;
    }
  }
}
