import 'dart:async';
import 'dart:math' as math;

import 'package:dynamic_bounce/components/ball.dart';
import 'package:dynamic_bounce/components/bat.dart';
import 'package:dynamic_bounce/components/brick.dart';
import 'package:dynamic_bounce/components/play_area.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The status of the game.
enum PlayStatus {
  /// Home screen of the game.
  home,

  /// The game is currently playing.
  playing,

  /// The score screen after game over.
  score,

  /// The ranking screen.
  ranking,

  /// The user details screen.
  user,

  /// The settings screen.
  settings,
}

/// The game instance.
class DynamicBounceGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  /// The width of the game.
  double get width => size.x;

  /// The height of the game.
  double get height => size.y;

  /// The status of the game.
  late PlayStatus _playStatus;

  /// Gets the status of the game.
  PlayStatus get playStatus => _playStatus;

  set playStatus(PlayStatus playStatus) {
    _playStatus = playStatus;
    _switchOverlay(playStatus);
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    // Set the origin of the game world to the top-left corner.
    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(
      PlayArea(),
    );

    playStatus = PlayStatus.home;
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);
    const stepScale = 60.0;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Bat>().first.moveBy(-stepScale);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Bat>().first.moveBy(stepScale);
    }
    return KeyEventResult.handled;
  }

  /// Switches another overlay.
  void _switchOverlay(PlayStatus playStatus) {
    _removeAllOverlays();
    if (PlayStatus.playing != playStatus) {
      overlays.add(playStatus.name);
    }
  }

  /// Removes all overlays.
  void _removeAllOverlays() {
    for (final playStatusName in PlayStatus.values) {
      if (overlays.isActive(playStatusName.name)) {
        overlays.remove(playStatusName.name);
      }
    }
  }

  /// Removes all objects from the game world.
  void removeAllObjects() {
    world
      ..removeAll(
        world.children.query<Ball>(),
      )
      ..removeAll(
        world.children.query<Bat>(),
      )
      ..removeAll(
        world.children.query<Brick>(),
      );
  }

  /// Starts the game.
  void startGame() {
    if (playStatus == PlayStatus.playing) return;

    playStatus = PlayStatus.playing;

    // The initial velocity parameters of the ball.
    // The ball will move in a random direction.
    final velocityX = math.Random().nextDouble() - 0.5;
    const velocityY = 1.0;
    const velocityScale = 250.0;

    world
      ..add(
        Ball(
          velocity: Vector2(
            velocityX,
            velocityY,
          ).normalized()
            ..scale(velocityScale),
          // Place the ball in the center of the screen.
          position: size / 2,
        ),
      )
      ..add(
        Bat(
          position: Vector2(
            width / 2,
            height * 0.95,
          ),
          size: Vector2(120, 10),
        ),
      )
      ..add(
        Brick(
          position: Vector2(
            width / 2,
            height * 0.10,
          ),
        ),
      );

    // TODO(me): Delete in the final version.
    debugMode = true;
  }

  @override
  Color backgroundColor() => Colors.white;
}
