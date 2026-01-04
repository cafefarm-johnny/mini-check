import 'package:mini_check/app/database.dart';
import 'package:uuid/uuid.dart';

class Todo {
  Todo({
    required this.title,
    required this.isDone,
    String? id,
    DateTime? createdAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  final String id;
  final String title;
  final bool isDone;
  final DateTime createdAt;

  factory Todo.fromTableData(TodoTableData data) {
    return Todo(
      id: data.uuid,
      title: data.title,
      isDone: data.isDone,
      createdAt: data.createdAt,
    );
  }

  Todo copyWith({
    String? title,
    bool? isDone,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt,
    );
  }
}
