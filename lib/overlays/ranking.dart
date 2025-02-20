import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/models/player_score.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The ranking overlay.
class Ranking extends ConsumerWidget {
  /// Creates a new ranking overlay.
  const Ranking({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const rankingNum = 100;
    final playerScores = List.generate(
      rankingNum,
      (index) => PlayerScore(
        userId: 'u${index + 1}',
        score: rankingNum - index,
      ),
    );
    return Column(
      children: [
        BackButton(ref: ref),
        RankingScores(playerScores: playerScores),
      ],
    );
  }
}

/// The back button to return to home.
class BackButton extends StatelessWidget {
  /// Creates a new back button.
  const BackButton({
    required this.ref,
    super.key,
  });

  /// The widget reference.
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 30,
          onPressed: () {
            ref
                .read(playStatusProvider.notifier)
                .updatePlayStatus(PlayStatusType.home);
          },
        ),
      ),
    );
  }
}

/// The ranking scores.
class RankingScores extends StatelessWidget {
  /// Creates a new ranking scores.
  const RankingScores({
    required this.playerScores,
    super.key,
  });

  /// Player scores
  final List<PlayerScore> playerScores;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: playerScores.length,
          itemBuilder: (context, index) {
            final playerScore = playerScores[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  RankText(value: index + 1),
                  const SizedBox(width: 15),
                  const UserNameText(),
                  const Spacer(),
                  ScoreText(playerScore: playerScore),
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

  /// The ranking value.
  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      alignment: Alignment.center,
      child: Text(
        '$value',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// User name text.
class UserNameText extends StatelessWidget {
  /// Creates a new user name text.
  const UserNameText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Unknown',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

/// Score text.
class ScoreText extends StatelessWidget {
  /// Creates a new score text.
  const ScoreText({
    required this.playerScore,
    super.key,
  });

  /// The player score.
  final PlayerScore playerScore;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${playerScore.score}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Colors.black,
      ),
    );
  }
}
