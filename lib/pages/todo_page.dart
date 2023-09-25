// pages/todo_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/bloc/todo_cubit/todo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/bloc/todo_cubit/todo_state.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_todo_app/pages/edit_todo_page.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<TodoCubit>()
        .getTodos(); // This fetches the todos on app start.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TODOs')),
      body: BlocBuilder<TodoCubit, TodoState>(
        // buildWhen: (p, c) => true,
        builder: (context, state) {
          // return Text('${state is TodosLoadingState}');
          if (state is TodosLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodosLoadedState) {
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                return _buildTodoItem(
                    context, state.todos[index]); // Use the custom method here
              },
            );
          } else if (state is TodosErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          // Initial state
          return const Center(child: Text('Start by adding your todos ss!'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget _buildTodoItem(BuildContext context, Todo todo) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: ListTile(
      title: Text(todo.title),
      subtitle: Text(todo.content),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditTodoPage(todo: todo),
              ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete Confirmation'),
                  content:
                      const Text('Are you sure you want to delete this todo?'),
                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        context.read<TodoCubit>().deleteTodo(todo.id);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

Future<void> _showAddTodoDialog(BuildContext context) async {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Add Todo'),
        content: FormBuilder(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: 'title',
                decoration: const InputDecoration(labelText: 'Todo Title'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'description',
                decoration: const InputDecoration(labelText: 'Description'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                // Get the values from the form
                final title = formKey.currentState?.value['title'];
                final description = formKey.currentState?.value['description'];

                final newTodo = Todo(
                  title: title,
                  content: description,
                  isDone: false, // default to false for new todos
                );

                context.read<TodoCubit>().addTodo(newTodo);

                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      );
    },
  );
}
