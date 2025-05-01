import 'package:drift/drift.dart';

// --- Tables ---
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get token => text().nullable()();
  DateTimeColumn get lastLogin => dateTime().named('last_login').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Profiles extends Table {
  TextColumn get userId => text().references(Users, #id)(); // Foreign key
  TextColumn get name => text().nullable()();
  TextColumn get phoneNumber => text().named('phone_number').nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get profilePictureUrl =>
      text().named('profile_picture_url').nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId};
}
