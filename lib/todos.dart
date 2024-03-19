import 'package:flutter/material.dart';
import 'package:todopractice/create_todo.dart';
import 'package:todopractice/models/todo.dart';
import 'package:todopractice/todo_list/todo_list.dart';

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() {
    return _TodosState();
  }
}

class _TodosState extends State<Todos> {
  var _order = 'asc';
  final List<Todo> _todos = [
    Todo(
      title: 'Learn Flutter🐥',
      date: DateTime.now(),
    ),
    Todo(
      title: 'Eat Chicken🍗',
      date: DateTime.now(),
    )
  ];

  List<Todo> get _orderedTodos {
    final sortedTodos = List.of(_todos);
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.title.compareTo(b.title);
      return _order == 'asc' ? bComesAfterA : -bComesAfterA;
    });
    return sortedTodos;
  }

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  void _openCreateTodoOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => CreateTodo(onAddTodo: _submitTodo),
    );
  }

  void _submitTodo(Todo todo) {
    setState(() {
      _todos.add(todo);
    });
  }

  void _removeTodo(Todo todo) {
    final todosIndex = _todos.indexOf(todo);

    setState(() {
      _todos.remove(todo);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Todo deleted!'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _todos.insert(todosIndex, todo);
            });
          },
        )));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('Nothing To do.'),
    );

    if (_todos.isNotEmpty) {
      mainContent = TodoList(
        todos: _orderedTodos,
        onRemoveTodo: _removeTodo,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'To-Do-List',
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: _openCreateTodoOverlay,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: _changeOrder,
                icon: Icon(_order == 'asc'
                    ? Icons.arrow_downward
                    : Icons.arrow_upward),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                child: mainContent,
              ),
            ),
          ],
        ));
  }
}
