/// player score
class PlayerScore {
  /// Creates a new player score.
  const PlayerScore({
    required this.userId,
    required this.score,
  });

  /// Creates a new player score from a JSON map.
  PlayerScore.fromJson({
    required Map<String, dynamic> json,
    required String id,
  })  : userId = id,
        score = json['score'] as int;

  /// The user id.
  final String userId;

  /// The score.
  final int score;

  /// Converts this player score to a JSON map.
  Map<String, dynamic> toJson() => {
        'id': userId,
        'score': score,
      };
}
