import 'package:flutter/material.dart';

import 'package:todopractice/models/todo.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({super.key, required this.onAddTodo});

  final void Function(Todo todo) onAddTodo;

  @override
  State<CreateTodo> createState() {
    return _CreateTodoState();
  }
}

class _CreateTodoState extends State<CreateTodo> {
  final _todoController = TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content:
              const Text('Please make sure a valid title,date was entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Yup'))
          ]),
    );
  }

  void _submitTodoData() {
    if (_todoController.text.trim().isEmpty || _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddTodo(
      Todo(
        title: _todoController.text,
        date: _selectedDate!,
      ),
    );
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 45, 16, 18),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _todoController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text('What are you gonna do?'),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month_outlined),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _submitTodoData,
                      child: const Text('Im gonna Do!'),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
