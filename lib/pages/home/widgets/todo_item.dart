import 'package:flutter/material.dart';
import 'package:mini_check/features/home/domain/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    this.onCheckboxChanged,
  });

  final ValueChanged<bool>? onCheckboxChanged;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.isDone,
        onChanged: (v) {
          onCheckboxChanged?.call(v ?? false);
        },
      ),
      title: Text(todo.title),
    );
  }
}
