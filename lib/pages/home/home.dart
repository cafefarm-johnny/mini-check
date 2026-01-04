import 'package:flutter/material.dart';
import 'package:mini_check/features/home/domain/todo.dart';
import 'package:mini_check/pages/home/widgets/todo_bottom_sheet.dart';
import 'package:mini_check/pages/home/widgets/todo_empty.dart';
import 'package:mini_check/pages/home/widgets/todo_list_view.dart';
import 'package:mini_check/shared/utils/snack_bar_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todos = <Todo>[];

  void _handleChangeTodo(Todo todo, bool isDone) {
    final targetIndex = todos.indexWhere((t) => t.id == todo.id);

    if (targetIndex == -1) {
      return;
    }

    setState(() {
      todos[targetIndex] = todos[targetIndex].copyWith(isDone: isDone);
    });
  }

  void _handleRemoveTodo(Todo todo) {
    final targetIndex = todos.indexWhere((t) => t.id == todo.id);
    if (targetIndex == -1) {
      return;
    }

    final targetTodo = todos[targetIndex];
    setState(() => todos.removeAt(targetIndex));

    SnackBarUtils.show(
      context: context,
      message: "'${targetTodo.title}'\n할 일이 삭제되었어요.",
      label: '되돌리기',
      onPressed: () {
        if (mounted) {
          setState(() {
            todos.insert(targetIndex.clamp(0, todos.length), targetTodo);
          });
        }
      },
    );
  }

  void _showTodoBottomSheet() async {
    final todoTitle = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => const TodoBottomSheet(),
    );

    if (mounted) {
      if (todoTitle != null && todoTitle.isNotEmpty) {
        setState(() => todos.add(Todo(title: todoTitle, isDone: false)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('오늘의 할 일')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: _createBody(todos),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTodoBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _createBody(List<Todo> todos) {
    if (todos.isEmpty) {
      return const TodoEmpty();
    }

    return TodoListView(
      todos: todos,
      onChanged: _handleChangeTodo,
      onRemoved: _handleRemoveTodo,
    );
  }
}
