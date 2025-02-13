import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The home overlay.
class Home extends StatelessWidget {
  /// Creates a new home overlay.
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          /// The title of the game.
          Text(
            'DYNAMIC BOUNCE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),

          /// The play button.
          PlayButton(),

          /// The icon buttons.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RankingButton(),
              UserButton(),
              SettingsButton(),
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
    super.key,
  });

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
    super.key,
  });

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
    super.key,
  });

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
    super.key,
  });

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
