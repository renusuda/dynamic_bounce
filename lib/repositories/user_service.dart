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
  /// The instance of the local database.
  static final instance = LocalDatabase();

  /// The table name.
  static const _tableName = LocalDatabase.tableName;

  /// The column name for the user id.
  static const _columnUserId = LocalDatabase.columnUserId;

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
}
