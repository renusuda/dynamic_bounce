import 'package:dynamic_bounce/models/player_score.dart';
import 'package:dynamic_bounce/models/ranked_player_score.dart';
import 'package:dynamic_bounce/repositories/score_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ranked_player_scores.g.dart';

/// Ranked player scores provider
@riverpod
class RankedPlayerScores extends _$RankedPlayerScores {
  @override
  List<RankedPlayerScore> build() => [];

  /// Update latest ranked player scores
  Future<void> updateLatest() async {
    final playerScores =
        await ref.read(scoreServiceProvider).getTopPlayerScores();
    if (playerScores.isEmpty) {
      state = [];
      return;
    }
    final rankedPlayerScores = _getRankedPlayerScores(playerScores);
    state = rankedPlayerScores;
  }

  List<RankedPlayerScore> _getRankedPlayerScores(
    List<PlayerScore> scores,
  ) {
    final rankedScores = <RankedPlayerScore>[];
    var currentRank = 1;
    var prevScore = scores.first.score;

    for (var i = 0; i < scores.length; i++) {
      // Assign the same rank to identical scores.
      if (scores[i].score < prevScore) {
        currentRank++;
      }
      rankedScores.add(
        RankedPlayerScore(
          player: scores[i].player,
          score: scores[i].score,
          rank: currentRank,
        ),
      );
      prevScore = scores[i].score;
    }

    return rankedScores;
  }
}
