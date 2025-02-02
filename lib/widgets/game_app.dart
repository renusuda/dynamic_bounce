import 'package:dynamic_bounce/dynamic_bounce_game.dart';
import 'package:dynamic_bounce/overlays/home.dart';
import 'package:dynamic_bounce/overlays/ranking.dart';
import 'package:dynamic_bounce/overlays/score.dart';
import 'package:dynamic_bounce/overlays/settings.dart';
import 'package:dynamic_bounce/overlays/user.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// The game app.
class GameApp extends StatelessWidget {
  /// Creates a new game app.
  const GameApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: FittedBox(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GameWidget<DynamicBounceGame>.controlled(
                    gameFactory: DynamicBounceGame.new,
                    overlayBuilderMap: {
                      PlayStatus.home.name: (_, game) => Home(game: game),
                      PlayStatus.score.name: (_, __) => const Score(),
                      PlayStatus.ranking.name: (_, __) => const Ranking(),
                      PlayStatus.user.name: (_, __) => const User(),
                      PlayStatus.settings.name: (_, __) => const Settings(),
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
