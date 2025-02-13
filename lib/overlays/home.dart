import 'package:dynamic_bounce/widgets/buttons/play_button.dart';
import 'package:dynamic_bounce/widgets/buttons/ranking_button.dart';
import 'package:dynamic_bounce/widgets/buttons/settings_button.dart';
import 'package:dynamic_bounce/widgets/buttons/user_button.dart';
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
