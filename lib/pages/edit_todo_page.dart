// pages/todo_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/bloc/todo_cubit/todo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EditTodoPage extends StatelessWidget {
  final Todo todo;

  const EditTodoPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: formKey,
          initialValue: {
            'title': todo.title,
            'content': todo.content,
          },
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(labelText: 'Title'),
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'content',
                decoration: const InputDecoration(labelText: 'Content'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    final updatedTodo = Todo(
                      id: todo.id,
                      title: formKey.currentState!.value['title'],
                      content: formKey.currentState!.value['content'],
                      isDone: todo.isDone,
                    );
                    context.read<TodoCubit>().updateTodo(updatedTodo);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Update Todo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
