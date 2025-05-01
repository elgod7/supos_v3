import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../modules/auth/data/datasources/user_table.dart';

part 'local_database.g.dart';

@DriftDatabase(tables: [Users, Profiles])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  close();

  Future<void> reset() async {
    await super.close();
    final file = File('localDb.sqlite');
    if (await file.exists()) {
      await file.delete();
    }
    await _openConnection();
  }

  @override
  int get schemaVersion => 1;

  // In your database class (e.g., `app_database.dart`)
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'localDatabase.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}

Future<void> resetDatabase() async {
  // Delete the database file
  final file = File('localDb.sqlite');
  if (await file.exists()) {
    await file.delete();
  }

  // Reopen a new connection (creates fresh DB)
  _openConnection();
}
