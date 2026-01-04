import 'package:drift/drift.dart';
import 'package:mini_check/app/database.dart';
import 'package:mini_check/entities/todo/todo_entity.dart';

part 'todo_repository.g.dart';

@DriftAccessor(tables: [TodoTable])
class TodoRepository extends DatabaseAccessor<AppDatabase>
    with _$TodoRepositoryMixin {
  TodoRepository(super.db);

  Stream<List<TodoTableData>> fetchTodos() {
    final selectStatement = select(todoTable)
      ..orderBy([
        (t) => OrderingTerm(
          expression: t.createdAt,
          mode: OrderingMode.desc,
        ),
      ]);

    return selectStatement.watch();
  }

  Future<void> insertTodo(TodoTableCompanion todo) {
    return into(todoTable).insert(todo);
  }

  Future<void> updateTodo({
    required String uuid,
    String? title,
    bool? isDone,
  }) {
    final updateStatement = update(todoTable)
      ..where((t) => t.uuid.equals(uuid));

    return updateStatement.write(
      TodoTableCompanion(
        title: Value.absentIfNull(title),
        isDone: Value.absentIfNull(isDone),
      ),
    );
  }

  Future<void> deleteTodo(String uuid) {
    final deleteStatement = delete(todoTable)
      ..where((t) => t.uuid.equals(uuid));

    return deleteStatement.go();
  }
}
