import 'package:dynamic_bounce/models/player.dart' as player_model;
import 'package:dynamic_bounce/repositories/player_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'player.g.dart';

/// play status provider
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

  /// Updates the player info in local storage.
  Future<void> updatePlayerName(String playerName) async {
    await _playerService.updatePlayer(playerName);
  }
}
