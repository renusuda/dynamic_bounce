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
  Future<void> upsert(int score) async {
    if (score < 1) return;
    final bestScore = await ref.watch(scoreServiceProvider).getBestScore();
    if (score > bestScore) {
      await ref.watch(scoreServiceProvider).updateBestScore(score);
      await ref.watch(scoreServiceProvider).upsertScore(score);
    }
  }
}
