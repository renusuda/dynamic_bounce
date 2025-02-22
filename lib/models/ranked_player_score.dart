import 'package:dynamic_bounce/models/player_score.dart';

/// Player score with rank.
class RankedPlayerScore extends PlayerScore {
  /// Creates a new player score.
  const RankedPlayerScore({
    required super.player,
    required super.score,
    required this.rank,
  });

  /// The rank.
  final int rank;
}
