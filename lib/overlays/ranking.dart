import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:dynamic_bounce/providers/ranked_player_scores.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BackButton(),
        RankingScores(),
      ],
    );
  }
}

/// Back button to return to home.
class BackButton extends ConsumerWidget {
  /// Creates a new back button.
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
class RankingScores extends ConsumerWidget {
  /// Creates a new ranking scores.
  const RankingScores({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rankedPlayerScores = ref.watch(rankedPlayerScoresProvider);
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
                  const UserNameText(),
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
    required this.value,
    super.key,
  });

  /// Score value.
  final int value;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$value',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Colors.black,
      ),
    );
  }
}
