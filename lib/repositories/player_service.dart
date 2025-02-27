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

  /// Whether the player is deleted.
  static const _columnIsDeletedAccount = LocalDatabase.columnIsDeletedAccount;

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

  /// Update the player.
  Future<void> updatePlayer(String playerName) async {
    final db = await instance.database;
    final playerId = await getPlayerId();
    await db.update(
      _tableName,
      {
        _columnPlayerName: playerName,
      },
      where: '$_columnPlayerId = ?',
      whereArgs: [playerId],
    );
  }

  /// Get whether the player is deleted.
  Future<bool> getIsPlayerDeleted() async {
    final db = await instance.database;
    final result = await db.query(
      _tableName,
      columns: [
        _columnIsDeletedAccount,
      ],
    );
    return result.first[_columnIsDeletedAccount] == 1;
  }
}
