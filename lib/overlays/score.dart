import 'package:dynamic_bounce/providers/score.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The score overlay.
class Score extends ConsumerWidget {
  /// Creates a new score overlay.
  const Score({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(scoreProvider);
    return Center(
      child: Text(
        'SCORE: $score',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
