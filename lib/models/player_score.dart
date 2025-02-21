import 'package:dynamic_bounce/models/user.dart';

/// player score
class PlayerScore {
  /// Creates a new player score.
  const PlayerScore({
    required this.user,
    required this.score,
  });

  /// Creates a new player score from a JSON map.
  PlayerScore.fromJson({
    required Map<String, dynamic> json,
    required String id,
  })  : user = User(
          id: id,
          name: json['name'] as String,
        ),
        score = json['score'] as int;

  /// The user id.
  final User user;

  /// The score.
  final int score;

  /// Converts this player score to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': user.id,
        'name': user.name,
        'score': score,
      };
}
