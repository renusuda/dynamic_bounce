import 'package:dynamic_bounce/models/player.dart';

/// player score
class PlayerScore {
  /// Creates a new player score.
  const PlayerScore({
    required this.player,
    required this.score,
  });

  /// Creates a new player score from a JSON map.
  PlayerScore.fromJson({
    required Map<String, dynamic> json,
    required String id,
  })  : player = Player(
          id: id,
          name: json['name'] as String,
        ),
        score = json['score'] as int;

  /// The player id.
  final Player player;

  /// The score.
  final int score;

  /// Converts this player score to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': player.id,
        'name': player.name,
        'score': score,
      };
}
