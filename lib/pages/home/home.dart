import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:mini_check/app/database.dart';
import 'package:mini_check/features/home/domain/todo.dart';
import 'package:mini_check/features/home/domain/todo_repository.dart';
import 'package:mini_check/pages/home/widgets/todo_bottom_sheet.dart';
import 'package:mini_check/pages/home/widgets/todo_empty.dart';
import 'package:mini_check/pages/home/widgets/todo_list_view.dart';
import 'package:mini_check/shared/utils/run_utils.dart';
import 'package:mini_check/shared/utils/snack_bar_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TodoRepository _todoRepository;

  Future<void> _handleChangeTodo(Todo todo, bool isDone) async {
    await RunUtils.run(
      () => _todoRepository.updateTodo(
        uuid: todo.id,
        isDone: isDone,
      ),
      context: context,
      failMessage: '할 일 완료 처리에 실패했어요. 다시 시도해주세요.',
    );
  }

  Future<void> _handleRemoveTodo(Todo todo) async {
    final result = await RunUtils.run(
      () => _todoRepository.deleteTodo(todo.id),
      context: context,
      failMessage: '할 일 삭제에 실패했어요. 다시 시도해주세요.',
    );

    if (!mounted || result.status.isFailure) {
      return;
    }

    SnackBarUtils.show(
      context: context,
      message: "'${todo.title}'\n할 일이 삭제되었어요.",
      label: '되돌리기',
      onPressed: () async {
        await RunUtils.run(
          () => _todoRepository.insertTodo(
            TodoTableCompanion.insert(
              uuid: todo.id,
              title: todo.title,
              createdAt: Value(todo.createdAt),
            ),
          ),
          context: context,
          failMessage: '할 일 추가에 실패했어요. 다시 시도해주세요.',
        );
      },
    );
  }

  Future<void> _showTodoBottomSheet() async {
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

    if (mounted && todoTitle != null && todoTitle.isNotEmpty) {
      await RunUtils.run(
        () async {
          final todo = Todo(title: todoTitle, isDone: false);
          await _todoRepository.insertTodo(
            TodoTableCompanion.insert(
              uuid: todo.id,
              title: todo.title,
              createdAt: Value(todo.createdAt),
            ),
          );
        },
        context: context,
        failMessage: '할 일 추가에 실패했어요. 다시 시도해주세요.',
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _todoRepository = TodoRepository(AppDatabase.instance);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('오늘의 할 일')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: StreamBuilder<List<TodoTableData>>(
          stream: _todoRepository.fetchTodos(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const TodoEmpty();
            }

            return TodoListView(
              todos: snapshot.data!.map(Todo.fromTableData).toList(),
              onChanged: _handleChangeTodo,
              onRemoved: _handleRemoveTodo,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showTodoBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
