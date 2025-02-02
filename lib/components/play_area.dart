import 'dart:async';

import 'package:dynamic_bounce/dynamic_bounce_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// The play area of the game.
class PlayArea extends RectangleComponent
    with HasGameReference<DynamicBounceGame> {
  /// Creates a new play area with a predefined color.
  PlayArea()
      : super(
          paint: Paint()..color = playAreaColor,
          children: [
            RectangleHitbox(),
          ],
        );

  /// The color of the play area.
  static const playAreaColor = Colors.white;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(
      game.width,
      game.height,
    );
  }
}
