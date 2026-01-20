import 'package:dynamic_bounce/l10n/app_localizations.dart';
import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:dynamic_bounce/providers/player.dart';
import 'package:dynamic_bounce/widgets/buttons/play_button.dart';
import 'package:dynamic_bounce/widgets/buttons/player_button.dart';
import 'package:dynamic_bounce/widgets/buttons/ranking_button.dart';
import 'package:dynamic_bounce/widgets/buttons/settings_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The home overlay.
class Home extends ConsumerStatefulWidget {
  /// Creates a new home overlay.
  const Home({
    super.key,
  });

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Check if the player account is deleted.
      final isDeletedAccount =
          await ref.read(playerProvider.notifier).fetchIsPlayerDeleted();
      if (isDeletedAccount) {
        ref
            .read(playStatusProvider.notifier)
            .updatePlayStatus(PlayStatusType.deleted);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GameTitle(),
          PlayButton(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RankingButton(),
              PlayerButton(),
              SettingsButton(),
            ],
          ),
        ],
      ),
    );
  }
}

/// The title of the game.
class GameTitle extends StatelessWidget {
  /// Creates a new game title.
  const GameTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(
      l10n.appTitle,
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
