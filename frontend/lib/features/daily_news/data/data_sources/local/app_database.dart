import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'DAO/article_dao.dart';
import 'tables/article_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Articles], daos: [ArticleDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return driftDatabase(name: 'app_database');
}
