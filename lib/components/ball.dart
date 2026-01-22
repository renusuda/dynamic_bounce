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

  double _collisionCooldown = 0;

  /// Flag to prevent multiple game over triggers.
  bool _isGameOver = false;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;

    if (_collisionCooldown > 0) {
      _collisionCooldown -= dt;
    }

    // Check if ball is completely outside the screen
    _checkOutOfBounds();
  }

  /// Checks if the ball is completely outside the screen.
  void _checkOutOfBounds() {
    if (_isGameOver) return;

    final isCompletelyAbove = position.y + radius < 0;
    final isCompletelyBelow = position.y - radius > game.height;

    if (isCompletelyAbove || isCompletelyBelow) {
      _isGameOver = true;
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
    }
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

      final isLeftWallCollision = intersectionPoint.x <= epsilon;
      final isRightWallCollision = intersectionPoint.x >= game.width - epsilon;

      // Bounce off left/right walls only
      // Game over is handled in _checkOutOfBounds()
      if (isLeftWallCollision || isRightWallCollision) {
        velocity.x = -velocity.x;
      }
    } else if (other is Bat) {
      velocity.y = -velocity.y;
    } else if (other is DynamicIslandBlock) {
      if (_collisionCooldown <= 0) {
        const speedUpScale = 1.1;
        const maxSpeed = 800.0;

        velocity.y = -velocity.y;

        if (velocity.length < maxSpeed) {
          velocity.scale(speedUpScale);
        }

        ref.read(scoreProvider.notifier).increment();

        _collisionCooldown = 0.2;
      }
    }
  }
}
