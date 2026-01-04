import 'package:flutter/material.dart';
import 'package:mini_check/features/home/domain/todo.dart';
import 'package:mini_check/pages/home/widgets/todo_item.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({
    super.key,
    required this.todos,
    required this.onRemoved,
    this.onChanged,
  });

  final List<Todo> todos;
  final void Function(Todo todo, bool isDone)? onChanged;
  final void Function(Todo todo) onRemoved;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        final todo = todos[index];

        return Dismissible(
          key: ValueKey(todo.id),
          direction: .endToStart,
          movementDuration: const Duration(milliseconds: 500),
          background: _createRemoveBoxIcon(),
          onDismissed: (_) => onRemoved.call(todo),
          child: TodoItem(
            todo: todo,
            onCheckboxChanged: (value) {
              onChanged?.call(todo, value);
            },
          ),
        );
      },
    );
  }

  Widget _createRemoveBoxIcon() {
    return Container(
      alignment: .centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.red,
      child: const Icon(
        Icons.remove_circle,
        color: Colors.white,
      ),
    );
  }
}
