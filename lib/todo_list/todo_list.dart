import 'package:flutter/material.dart';
import 'package:todopractice/models/todo.dart';
import 'package:todopractice/todo_list/todo_item.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.todos, required this.onRemoveTodo});

  final List<Todo> todos;
  final void Function(Todo todo) onRemoveTodo;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, i) => Dismissible(
        key: ValueKey(todos[i]),
        onDismissed: (direction) {
          onRemoveTodo(todos[i]);
        },
        child: TodoItem(todos[i]),
      ),
    );
  }
}
