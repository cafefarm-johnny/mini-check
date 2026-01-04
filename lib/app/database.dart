import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mini_check/entities/todo/todo_entity.dart';
import 'package:mini_check/features/home/domain/todo_repository.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [TodoTable],
  daos: [TodoRepository],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal(super.executor) : super();

  static final _instance = AppDatabase._internal(_openConnection());
  static AppDatabase get instance => _instance;

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'mini_check.db'));
      return NativeDatabase(file);
    });
  }
}
