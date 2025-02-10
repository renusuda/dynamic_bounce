import 'dart:async';

import 'package:dynamic_bounce/components/play_area.dart';
import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';

/// The game instance.
class DynamicBounceGame extends FlameGame
    with HasCollisionDetection, TapDetector, RiverpodGameMixin {
  /// The width of the game.
  double get width => size.x;

  /// The height of the game.
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    // Set the origin of the game world to the top-left corner.
    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(
      PlayArea(),
    );

    _switchOverlay(
      ref.watch(playStatusProvider),
    );
  }

  @override
  void onMount() {
    addToGameWidgetBuild(() {
      ref.listen(playStatusProvider, (prev, next) {
        _switchOverlay(next);
      });
    });
    super.onMount();
  }

  /// Switches another overlay.
  void _switchOverlay(PlayStatusType playStatusType) {
    _removeAllOverlays();
    overlays.add(playStatusType.name);
  }

  /// Removes all overlays.
  void _removeAllOverlays() {
    for (final playStatusType in PlayStatusType.values) {
      if (overlays.isActive(playStatusType.name)) {
        overlays.remove(playStatusType.name);
      }
    }
  }

  @override
  Color backgroundColor() => Colors.white;
}
