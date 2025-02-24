import 'package:dynamic_bounce/providers/player.dart';
import 'package:dynamic_bounce/providers/ranked_player_scores.dart';
import 'package:dynamic_bounce/widgets/buttons/back_to_home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The ranking overlay.
class Ranking extends ConsumerStatefulWidget {
  /// Creates a new ranking overlay.
  const Ranking({
    super.key,
  });

  @override
  ConsumerState<Ranking> createState() => _RankingState();
}

class _RankingState extends ConsumerState<Ranking> {
  @override
  void initState() {
    super.initState();
    ref.read(rankedPlayerScoresProvider.notifier).updateLatest();
    ref.read(playerProvider.notifier).fetchPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BackToHomeButton(),
        RankingScores(),
      ],
    );
  }
}

/// The ranking scores.
class RankingScores extends ConsumerWidget {
  /// Creates a new ranking scores.
  const RankingScores({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankedPlayerScores = ref.watch(rankedPlayerScoresProvider);
    final player = ref.watch(playerProvider);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: rankedPlayerScores.length,
          itemBuilder: (context, index) {
            final rankedPlayerScore = rankedPlayerScores[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  RankText(value: rankedPlayerScore.rank),
                  const SizedBox(width: 15),
                  PlayerNameText(
                    playerName: rankedPlayerScore.player.name,
                    isMyScore: rankedPlayerScore.player.id == player.id,
                  ),
                  const Spacer(),
                  ScoreText(value: rankedPlayerScore.score),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Rank text.
class RankText extends StatelessWidget {
  /// Creates a new rank text.
  const RankText({
    required this.value,
    super.key,
  });

  /// Ranking value.
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      alignment: Alignment.center,
      child: Text(
        '$value',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

/// Player name text.
class PlayerNameText extends StatelessWidget {
  /// Creates a new player name text.
  const PlayerNameText({
    required this.playerName,
    required this.isMyScore,
    super.key,
  });

  /// Player name.
  final String playerName;

  /// Whether the player is current player.
  final bool isMyScore;

  @override
  Widget build(BuildContext context) {
    return Text(
      playerName,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: isMyScore ? Colors.deepOrangeAccent : null,
          ),
    );
  }
}

/// Score text.
class ScoreText extends StatelessWidget {
  /// Creates a new score text.
  const ScoreText({
    required this.value,
    super.key,
  });

  /// Score value.
  final int value;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$value',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
