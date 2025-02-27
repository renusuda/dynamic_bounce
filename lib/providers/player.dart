import 'package:dynamic_bounce/models/player.dart' as player_model;
import 'package:dynamic_bounce/repositories/local_database.dart';
import 'package:dynamic_bounce/repositories/player_service.dart';
import 'package:dynamic_bounce/repositories/score_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player.g.dart';

/// Player provider
@riverpod
class Player extends _$Player {
  /// Local database instance.
  static final _playerService = PlayerService();

  @override
  Future<player_model.Player> build() => fetchPlayer();

  /// Fetches the player info from local storage.
  Future<player_model.Player> fetchPlayer() async {
    final response = await _playerService.getPlayer();
    return response;
  }

  /// Fetches whether the player is deleted.
  Future<bool> fetchIsPlayerDeleted() async {
    final response = await _playerService.getIsPlayerDeleted();
    return response;
  }

  /// Updates the player info in local storage.
  Future<void> updatePlayerName(String playerName) async {
    await _playerService.updatePlayer(playerName);
  }

  /// Deletes all data.
  Future<void> deleteAll() async {
    await ref.read(scoreServiceProvider).deleteScore();
    final localDatabase = LocalDatabase();
    await localDatabase.deleteAcount();
    final user = FirebaseAuth.instance.currentUser;
    await user!.delete();
  }
}
