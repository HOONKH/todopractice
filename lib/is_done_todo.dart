import 'package:flutter/material.dart';

class IsDoneTodo extends StatefulWidget {
  const IsDoneTodo(this.title, this.formattedDate, {super.key});

  final String title;
  final String formattedDate;

  @override
  State<IsDoneTodo> createState() {
    return _IsDoneTodoState();
  }
}

class _IsDoneTodoState extends State<IsDoneTodo> {
  var _isDone = false;

  void _setIsDone(bool? isChecked) {
    setState(() {
      _isDone = isChecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(value: _isDone, onChanged: _setIsDone),
          const SizedBox(
            width: 8,
          ),
          Text(widget.title),
          const Spacer(),
          Text(widget.formattedDate)
        ],
      ),
    );
  }
}
// Row(
//           children: [
//             Text(
//               todo.title,
//             ),
//             const Spacer(),
//             Text(todo.formattedDate),
//           ],
//         ),