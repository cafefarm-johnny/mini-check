import 'package:uuid/uuid.dart';

class Todo {
  Todo({
    required this.title,
    required this.isDone,
    String? id,
  }) : id = id ?? const Uuid().v4();

  final String id;
  final String title;
  final bool isDone;

  Todo copyWith({
    String? title,
    bool? isDone,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }
}
