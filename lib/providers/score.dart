import 'package:collection/collection.dart';
import 'package:dynamic_bounce/models/score_result_type.dart';
import 'package:dynamic_bounce/repositories/score_service.dart';
import 'package:dynamic_bounce/repositories/user_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score.g.dart';

/// score provider
@riverpod
class Score extends _$Score {
  @override
  int build() => 0;

  /// increment score
  /// ignore: use_setters_to_change_properties
  void increment() => state++;

  /// reset score
  void reset() => state = 0;

  /// upsert score
  Future<ScoreResultType> upsert(int score) async {
    if (score < 1) return ScoreResultType.normal;

    final bestScore = await ref.read(scoreServiceProvider).getBestScore();
    if (score > bestScore) {
      await ref.read(scoreServiceProvider).updateBestScore(score);
      await ref.read(scoreServiceProvider).upsertScore(score);

      final isTopHundred = await isInTopHundred();
      return isTopHundred ? ScoreResultType.ranking : ScoreResultType.best;
    }

    return ScoreResultType.normal;
  }

  /// check if the score is in the top 100
  Future<bool> isInTopHundred() async {
    final topScores = await ref.read(scoreServiceProvider).getTopPlayerScores();
    final userId = await ref.read(userServiceProvider).getUserId();
    final myRankingScore = topScores.firstWhereOrNull(
      (score) => score.user.id == userId,
    );
    return myRankingScore != null;
  }
}
