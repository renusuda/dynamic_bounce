import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/overlays/deleted.dart';
import 'package:dynamic_bounce/overlays/home.dart';
import 'package:dynamic_bounce/overlays/player.dart';
import 'package:dynamic_bounce/overlays/playing.dart';
import 'package:dynamic_bounce/overlays/ranking.dart';
import 'package:dynamic_bounce/overlays/score.dart';
import 'package:dynamic_bounce/overlays/settings.dart';
import 'package:dynamic_bounce/providers/game.dart';
import 'package:dynamic_bounce/theme.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The game app.
class GameApp extends ConsumerWidget {
  /// Creates a new game app.
  const GameApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);
    return MaterialApp(
      theme: textTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja'), // Japanese
        Locale('en'), // English
      ],
      home: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: FittedBox(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: RiverpodAwareGameWidget(
                  key: gameWidgetKey,
                  game: game,
                  overlayBuilderMap: {
                    PlayStatusType.home.name: (_, __) => const Home(),
                    PlayStatusType.playing.name: (_, __) => Playing(game: game),
                    PlayStatusType.score.name: (_, __) => const Score(),
                    PlayStatusType.ranking.name: (_, __) => const Ranking(),
                    PlayStatusType.player.name: (_, __) => const Player(),
                    PlayStatusType.settings.name: (_, __) => const Settings(),
                    PlayStatusType.deleted.name: (_, __) => const Deleted(),
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
