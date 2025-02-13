import 'package:dynamic_bounce/providers/score.dart';
import 'package:dynamic_bounce/widgets/buttons/home_button.dart';
import 'package:dynamic_bounce/widgets/buttons/play_again_button.dart';
import 'package:dynamic_bounce/widgets/buttons/ranking_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The score overlay.
class Score extends StatelessWidget {
  /// Creates a new score overlay.
  const Score({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ScoreResult(),
          PlayAgainButton(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RankingButton(),
              HomeButton(),
            ],
          ),
        ],
      ),
    );
  }
}

/// The score result.
class ScoreResult extends ConsumerWidget {
  /// Creates a new score result.
  const ScoreResult({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(scoreProvider);
    return Text(
      '$score',
      style: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
