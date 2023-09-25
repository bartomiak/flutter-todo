// Import the necessary packages
import 'package:dio/dio.dart';

class AppRestClient {
  final Dio _dio = Dio();

  // The base URL for our backend service
  // For this tutorial, let's assume our backend API is hosted at 'https://todoapi.com'
  final String _baseUrl = 'http://localhost:3000';

  AppRestClient() {
    _dio.options.baseUrl = _baseUrl;

    // Set common headers, if needed (like 'Authorization' for API token, etc.)
    _dio.options.headers = {
      'Content-Type': 'application/json',
    };

    // Add Interceptor for logging requests (great for debugging!)
    // _dio.interceptors.add(
    //   LogInterceptor(
    //     request: true,
    //     requestBody: true,
    //     responseHeader: false,
    //     responseBody: true,
    //   ),
    // );
  }

  // READ: Fetch all todos
  Future<Response> getTodos() async {
    try {
      return await _dio.get('/todos');
    } catch (e) {
      rethrow; // Forward the error to be handled later
    }
  }

  // CREATE: Add a new todo
  Future<Response> addTodo(Map<String, dynamic> data) async {
    try {
      return await _dio.post('/todos', data: data);
    } catch (e) {
      rethrow;
    }
  }

  // UPDATE: Update a specific todo
  Future<Response> updateTodo(String? id, Map<String, dynamic> data) async {
    try {
      return await _dio.put('/todos/$id', data: data);
    } catch (e) {
      rethrow;
    }
  }

  // DELETE: Delete a specific todo
  Future<Response> deleteTodo(String? id) async {
    try {
      return await _dio.delete('/todos/$id');
    } catch (e) {
      rethrow;
    }
  }
}
