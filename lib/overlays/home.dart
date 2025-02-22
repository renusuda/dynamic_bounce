import 'package:dynamic_bounce/widgets/buttons/play_button.dart';
import 'package:dynamic_bounce/widgets/buttons/player_button.dart';
import 'package:dynamic_bounce/widgets/buttons/ranking_button.dart';
import 'package:dynamic_bounce/widgets/buttons/settings_button.dart';
import 'package:flutter/material.dart';

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
    return Text(
      'DYNAMIC BOUNCE',
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
