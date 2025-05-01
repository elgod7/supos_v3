import 'package:drift/drift.dart';
import 'package:supos_v3/database/local_database.dart' as localDb;

class LocalAuth {
  final localDb.LocalDatabase db;

  LocalAuth({required this.db});

  Future<localDb.User?> getUser(String id) async {
    return await (db.select(db.users)..where((u) => u.id.equals(id)))
        .getSingleOrNull();
  }

  Future<localDb.User?> getLastLoginUser() async {
    final lastUser = await (db.select(db.users)
          ..orderBy([(t) => OrderingTerm.desc(t.lastLogin)])
          ..limit(1))
        .getSingleOrNull();
    return lastUser;
  }

  Future<void> insertUser(localDb.User user) async {
    await db.into(db.users).insertOnConflictUpdate(user);
  }

  Future<void> deleteUser(String id) async {
    await (db.delete(db.users)..where((u) => u.id.equals(id))).go();
  }

  Future<void> clearAll() async {
    await db.delete(db.users).go();
  }
}
