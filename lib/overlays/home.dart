import 'package:dynamic_bounce/dynamic_bounce_game.dart';
import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The home overlay.
class Home extends StatelessWidget {
  /// Creates a new home overlay.
  const Home({
    required this.game,
    super.key,
  });

  /// The game instance.
  final DynamicBounceGame game;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// The title of the game.
          const Text(
            'DYNAMIC BOUNCE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),

          /// The play button.
          PlayButton(game: game),

          /// The icon buttons.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RankingButton(game: game),
              UserButton(game: game),
              SettingsButton(game: game),
            ],
          ),
        ],
      ),
    );
  }
}

/// The play button.
class PlayButton extends ConsumerWidget {
  /// Creates a new play button.
  const PlayButton({
    required this.game,
    super.key,
  });

  /// The game instance.
  final DynamicBounceGame game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const Text(
          'PLAY',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 36,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.play_circle_outline,
          ),
          iconSize: 72,
          onPressed: () {
            ref
                .read(playStatusProvider.notifier)
                .updatePlayStatus(PlayStatusType.playing);
          },
        ),
      ],
    );
  }
}

/// The ranking button.
class RankingButton extends ConsumerWidget {
  /// Creates a new ranking button.
  const RankingButton({
    required this.game,
    super.key,
  });

  /// The game instance.
  final DynamicBounceGame game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(
        Icons.emoji_events_outlined,
      ),
      iconSize: 72,
      onPressed: () {
        ref
            .read(playStatusProvider.notifier)
            .updatePlayStatus(PlayStatusType.ranking);
      },
    );
  }
}

/// The user button.
class UserButton extends ConsumerWidget {
  /// Creates a new user button.
  const UserButton({
    required this.game,
    super.key,
  });

  /// The game instance.
  final DynamicBounceGame game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(
        Icons.account_circle_outlined,
      ),
      iconSize: 72,
      onPressed: () {
        ref
            .read(playStatusProvider.notifier)
            .updatePlayStatus(PlayStatusType.user);
      },
    );
  }
}

/// The settings button.
class SettingsButton extends ConsumerWidget {
  /// Creates a new settings button.
  const SettingsButton({
    required this.game,
    super.key,
  });

  /// The game instance.
  final DynamicBounceGame game;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(
        Icons.settings_outlined,
      ),
      iconSize: 72,
      onPressed: () {
        ref
            .read(playStatusProvider.notifier)
            .updatePlayStatus(PlayStatusType.settings);
      },
    );
  }
}
