import 'package:dynamic_bounce/models/score_result_type.dart';
import 'package:dynamic_bounce/repositories/score_service.dart';
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
    final bestScore = await ref.watch(scoreServiceProvider).getBestScore();
    if (score > bestScore) {
      await ref.watch(scoreServiceProvider).updateBestScore(score);
      await ref.watch(scoreServiceProvider).upsertScore(score);
      // TODO(me): return ranking score if the score is in the top 100.
      return ScoreResultType.best;
    }
    return ScoreResultType.normal;
  }
}
