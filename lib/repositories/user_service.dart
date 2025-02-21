import 'package:dynamic_bounce/models/user.dart';
import 'package:dynamic_bounce/repositories/local_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_service.g.dart';

/// The user service provider.
@riverpod
UserService userService(Ref ref) {
  return UserService();
}

/// The user service.
class UserService {
  /// Local database instance.
  static final instance = LocalDatabase();

  /// Table name.
  static const _tableName = LocalDatabase.tableName;

  /// User ID column.
  static const _columnUserId = LocalDatabase.columnUserId;

  /// User name column.
  static const _columnUserName = LocalDatabase.columnUserName;

  /// Get the user id.
  Future<String> getUserId() async {
    final db = await instance.database;
    final result = await db.query(
      _tableName,
      columns: [
        _columnUserId,
      ],
    );
    return result.first[_columnUserId]! as String;
  }

  /// Get the user.
  Future<User> getUser() async {
    final db = await instance.database;
    final result = await db.query(
      _tableName,
      columns: [
        _columnUserId,
        _columnUserName,
      ],
    );
    return User.fromJson(
      json: result.first,
    );
  }
}
