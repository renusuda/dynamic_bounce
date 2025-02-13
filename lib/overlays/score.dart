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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// The score result.
          Text(
            '$score',
            style: const TextStyle(
              fontSize: 72,
              fontWeight: FontWeight.bold,
            ),
          ),

          /// The play again button.
          const PlayAgainButton(),

          /// The icon buttons.
          const Row(
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

/// The play again button.
class PlayAgainButton extends StatelessWidget {
  /// Creates a new play again button.
  const PlayAgainButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'PLAY AGAIN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.replay,
          ),
          iconSize: 72,
          onPressed: () {},
        ),
      ],
    );
  }
}

/// The ranking button.
class RankingButton extends StatelessWidget {
  /// Creates a new ranking button.
  const RankingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.emoji_events_outlined,
      ),
      iconSize: 72,
      onPressed: () {},
    );
  }
}

/// The home button.
class HomeButton extends StatelessWidget {
  /// Creates a new home button.
  const HomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.home_outlined,
      ),
      iconSize: 72,
      onPressed: () {},
    );
  }
}
