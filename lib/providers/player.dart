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
  player_model.Player build() => const player_model.Player.init();

  /// Fetches the player info from local storage.
  Future<void> fetchPlayer() async {
    final response = await _playerService.getPlayer();
    state = response;
  }
}
