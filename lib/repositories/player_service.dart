import 'package:dynamic_bounce/models/player.dart';
import 'package:dynamic_bounce/repositories/local_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player_service.g.dart';

/// The player service provider.
@riverpod
PlayerService playerService(Ref ref) {
  return PlayerService();
}

/// The player service.
class PlayerService {
  /// Local database instance.
  static final instance = LocalDatabase();

  /// Table name.
  static const _tableName = LocalDatabase.tableName;

  /// Player ID column.
  static const _columnPlayerId = LocalDatabase.columnPlayerId;

  /// Player name column.
  static const _columnPlayerName = LocalDatabase.columnPlayerName;

  /// Get the player id.
  Future<String> getPlayerId() async {
    final db = await instance.database;
    final result = await db.query(
      _tableName,
      columns: [
        _columnPlayerId,
      ],
    );
    return result.first[_columnPlayerId]! as String;
  }

  /// Get the player.
  Future<Player> getPlayer() async {
    final db = await instance.database;
    final result = await db.query(
      _tableName,
      columns: [
        _columnPlayerId,
        _columnPlayerName,
      ],
    );
    return Player.fromJson(
      json: result.first,
    );
  }
}
