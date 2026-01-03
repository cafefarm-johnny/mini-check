import 'package:flutter/material.dart';
import 'package:mini_check/features/home/domain/todo.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('오늘의 할 일')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: _createBody(todos),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
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
