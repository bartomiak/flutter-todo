// Import the required packages
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String? id;
  final String title;
  final String content;
  final bool isDone;

  const Todo({
    this.id,
    required this.title,
    required this.content,
    required this.isDone,
  });

  // Convert JSON data to Todo object
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      isDone: json['isDone'],
    );
  }

  // Convert Todo object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'isDone': isDone,
    };
  }

  @override
  List<Object?> get props => [id, title, content, isDone];
}
