import 'package:dynamic_bounce/models/score_result_type.dart';
import 'package:dynamic_bounce/providers/score.dart';
import 'package:dynamic_bounce/widgets/buttons/home_button.dart';
import 'package:dynamic_bounce/widgets/buttons/play_again_button.dart';
import 'package:dynamic_bounce/widgets/buttons/ranking_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The score overlay.
class Score extends ConsumerStatefulWidget {
  /// Creates a new score overlay.
  const Score({
    super.key,
  });

  @override
  ConsumerState<Score> createState() => _ScoreState();
}

class _ScoreState extends ConsumerState<Score> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final score = ref.read(scoreProvider);
      final scoreResult = await ref.read(scoreProvider.notifier).upsert(score);
      if (!mounted) return;
      switch (scoreResult) {
        case ScoreResultType.best:
          _showSnackBar(
            context,
            'New Best Score🎉',
          );
        case ScoreResultType.ranking:
          _showSnackBar(
            context,
            "You're in the top rankings🏆",
          );
        case ScoreResultType.normal:
          break;
      }
    });
  }

  void _showSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

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
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}
