import 'package:dynamic_bounce/components/bat.dart';
import 'package:dynamic_bounce/components/dynamic_island_block.dart';
import 'package:dynamic_bounce/components/play_area.dart';
import 'package:dynamic_bounce/dynamic_bounce_game.dart';
import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:dynamic_bounce/providers/score.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A ball that bounces around the screen.
class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<DynamicBounceGame> {
  /// Creates a new ball.
  Ball({
    required this.ref,
    required this.velocity,
    required super.position,
  }) : super(
          radius: 15,
          anchor: Anchor.center,
          paint: Paint()
            ..color = Colors.black
            ..style = PaintingStyle.fill,
          children: [
            CircleHitbox(),
          ],
        );

  /// The widget reference.
  final WidgetRef ref;

  /// The velocity of the ball.
  final Vector2 velocity;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollision(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollision(
      intersectionPoints,
      other,
    );

    if (other is PlayArea) {
      final intersectionPoint = intersectionPoints.first;

      // Loosen the collision detection.
      const epsilon = 0.1;

      final isTopWallCollision = intersectionPoint.y <= epsilon;
      final isLeftWallCollision = intersectionPoint.x <= epsilon;
      final isRightWallCollision = intersectionPoint.x >= game.width - epsilon;
      final isBottomWallCollision =
          intersectionPoint.y >= game.height - epsilon;
      if (isTopWallCollision || isBottomWallCollision) {
        add(
          RemoveEffect(
            delay: 0.35,
            onComplete: () {
              ref
                  .read(playStatusProvider.notifier)
                  .updatePlayStatus(PlayStatusType.score);
            },
          ),
        );
      } else if (isLeftWallCollision || isRightWallCollision) {
        velocity.x = -velocity.x;
      }
    } else if (other is Bat) {
      velocity.y = -velocity.y;
    } else if (other is DynamicIslandBlock) {
      const speedUpScale = 1.1;
      velocity
        ..y = -velocity.y
        ..scale(speedUpScale);
      ref.read(scoreProvider.notifier).increment();
    }
  }
}
