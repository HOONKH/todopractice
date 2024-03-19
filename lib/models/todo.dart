import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

class Todo {
  Todo({
    required this.title,
    required this.date,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;

  String get formattedDate {
    return formatter.format(date);
  }
}
