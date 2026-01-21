import 'dart:io';
// import 'dart:math' as math;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dynamic_bounce/components/ball.dart';
import 'package:dynamic_bounce/components/bat.dart';
import 'package:dynamic_bounce/components/dynamic_island_block.dart';
import 'package:dynamic_bounce/dynamic_bounce_game.dart';
import 'package:dynamic_bounce/providers/score.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The playing overlay.
class Playing extends ConsumerStatefulWidget {
  /// Creates a new playing overlay.
  const Playing({
    required this.game,
    super.key,
  });

  /// The game instance.
  final DynamicBounceGame game;

  @override
  ConsumerState<Playing> createState() => _PlayingState();
}

class _PlayingState extends ConsumerState<Playing> {
  @override
  Widget build(BuildContext context) {
    final score = ref.watch(scoreProvider);
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Text(
            '$score',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  void dispose() {
    // Remove all objects when game is over.
    _removeAllObjects();
    super.dispose();
  }

  /// Starts the game.
  Future<void> _startGame() async {
    // The initial velocity parameters of the ball.
    // Ensure minimum horizontal movement to prevent near-vertical trajectories.
    // const minVelocityX = 0.35;
    // const maxVelocityX = 0.7;
    // final random = math.Random();
    // final absVelocityX =
    //     minVelocityX + random.nextDouble() * (maxVelocityX - minVelocityX);
    // final sign = random.nextBool() ? 1 : -1;
    // final velocityX = absVelocityX * sign;

    // TEST: Vertical drop for testing
    const velocityX = 0.0;
    const velocityY = 1.0;
    const velocityScale = 250.0;

    final hasDynamicIsland = await _getHasDynamicIsland();

    widget.game.world
      ..add(
        Ball(
          ref: ref,
          velocity: Vector2(
            velocityX,
            velocityY,
          ).normalized()
            ..scale(velocityScale),
          // Place the ball in the center of the screen.
          position: widget.game.size / 2,
        ),
      )
      ..add(
        Bat(
          position: Vector2(
            widget.game.width / 2,
            widget.game.height * 0.9,
          ),
          size: Vector2(120, 25),
        ),
      )
      ..add(
        DynamicIslandBlock(
          position: Vector2(
            widget.game.width / 2,
            hasDynamicIsland ? 0 : 30,
          ),
        ),
      );
  }

  Future<bool> _getHasDynamicIsland() async {
    if (!Platform.isIOS) {
      return false;
    }

    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;
    final iphoneModel = iosInfo.utsname.machine;
    // iPhone 14 Pro or later has dynamic island.
    // iPhone 14 Pro: 'iPhone15.2'
    // iPhone 14 Pro Max: 'iPhone15.3'
    // iPhone 15: 'iPhone15.4'
    // ...
    // iPhone 16 Plus: 'iPhone17,4'
    // Get the major version and minor version from the model String.
    final match = RegExp(r'iPhone(\d+),(\d+)').firstMatch(iphoneModel);
    if (match == null) {
      return false;
    }

    final majorVersion = int.parse(match.group(1)!);
    final minorVersion = int.parse(match.group(2)!);

    if (majorVersion > 15 || (majorVersion == 15 && minorVersion >= 2)) {
      return true;
    }

    return false;
  }

  /// Removes all objects from the game world.
  void _removeAllObjects() {
    widget.game.world
      ..removeAll(
        widget.game.world.children.query<Ball>(),
      )
      ..removeAll(
        widget.game.world.children.query<Bat>(),
      )
      ..removeAll(
        widget.game.world.children.query<DynamicIslandBlock>(),
      );
  }
}
