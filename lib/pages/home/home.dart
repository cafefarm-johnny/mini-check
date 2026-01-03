import 'package:flutter/material.dart';
import 'package:mini_check/features/home/domain/todo.dart';
import 'package:mini_check/pages/home/widgets/todo_bottom_sheet.dart';
import 'package:mini_check/pages/home/widgets/todo_empty.dart';
import 'package:mini_check/pages/home/widgets/todo_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todos = <Todo>[];

  void _toggleTodo(int index, bool isDone) {
    setState(() {
      todos[index] = todos[index].copyWith(isDone: isDone);
    });
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
      onTodoChanged: _toggleTodo,
    );
  }
}
