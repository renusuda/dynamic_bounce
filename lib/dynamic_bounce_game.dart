import 'dart:async';

import 'package:dynamic_bounce/components/play_area.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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
    with HasCollisionDetection, TapDetector {
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

  /// Switches another overlay.
  void _switchOverlay(PlayStatus playStatus) {
    _removeAllOverlays();
    overlays.add(playStatus.name);
  }

  /// Removes all overlays.
  void _removeAllOverlays() {
    for (final playStatusName in PlayStatus.values) {
      if (overlays.isActive(playStatusName.name)) {
        overlays.remove(playStatusName.name);
      }
    }
  }

  @override
  Color backgroundColor() => Colors.white;
}
