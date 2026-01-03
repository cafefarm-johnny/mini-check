import 'package:flutter/material.dart';
import 'package:mini_check/features/home/domain/todo.dart';
import 'package:mini_check/pages/home/widgets/todo_item.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({
    super.key,
    required this.todos,
    this.onTodoChanged,
  });

  final List<Todo> todos;
  final void Function(int index, bool isDone)? onTodoChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return TodoItem(
          todo: todos[index],
          onCheckboxChanged: (value) {
            onTodoChanged?.call(index, value);
          },
        );
      },
    );
  }
}
