import 'package:flutter/material.dart';
import 'package:todopractice/is_done_todo.dart';
import 'package:todopractice/models/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(this.todo, {super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        child: Row(
          children: [
            Expanded(
              child: IsDoneTodo(
                  key: ValueKey(todo), todo.title, todo.formattedDate),
            )
          ],
        ),
      ),
    );
  }
}
