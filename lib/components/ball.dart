import 'dart:math' as math;

import 'package:dynamic_bounce/components/bat.dart';
import 'package:dynamic_bounce/components/dynamic_island_block.dart';
import 'package:dynamic_bounce/dynamic_bounce_game.dart';
import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:dynamic_bounce/providers/score.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A ball that bounces around the screen.
class Ball extends CircleComponent with HasGameReference<DynamicBounceGame> {
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
        );

  /// The widget reference.
  final WidgetRef ref;

  /// The velocity of the ball.
  final Vector2 velocity;

  double _collisionCooldown = 0;

  /// Flag to prevent multiple game over triggers.
  bool _isGameOver = false;

  /// Cached reference to the bat component.
  Bat? _bat;

  /// Cached reference to the dynamic island block component.
  DynamicIslandBlock? _block;

  @override
  void update(double dt) {
    super.update(dt);

    if (_collisionCooldown > 0) {
      _collisionCooldown -= dt;
    }

    // Cache references to bat and block
    _cacheComponents();

    // Sub-stepping: divide movement into smaller steps to prevent tunneling
    final subSteps = _calculateSubSteps(dt);
    final timePerStep = dt / subSteps;

    for (var i = 0; i < subSteps; i++) {
      position += velocity * timePerStep;

      // Check all collisions at each sub-step
      _checkWallCollisions();
      _checkBatCollision();
      _checkBlockCollision();
    }

    // Check if ball is completely outside the screen
    _checkOutOfBounds();
  }

  /// Caches references to bat and block components for efficient access.
  void _cacheComponents() {
    if (_bat == null || _block == null) {
      final components = parent?.children;
      if (components != null) {
        for (final component in components) {
          if (component is Bat) {
            _bat = component;
          } else if (component is DynamicIslandBlock) {
            _block = component;
          }
        }
      }
    }
  }

  /// Calculates the number of sub-steps needed for this frame.
  ///
  /// Divides movement into smaller steps to prevent tunneling through objects.
  int _calculateSubSteps(double dt) {
    // Maximum distance per step (set to ball radius to prevent tunneling)
    const maxStepDistance = 15.0;
    // Maximum sub-steps per frame to limit CPU usage
    const maxSubSteps = 10;

    final moveDistance = velocity.length * dt;
    return (moveDistance / maxStepDistance).ceil().clamp(1, maxSubSteps);
  }

  /// Checks and handles wall collisions during sub-stepping.
  void _checkWallCollisions() {
    // Left wall
    if (position.x - radius < 0) {
      position.x = radius;
      if (velocity.x < 0) velocity.x = -velocity.x;
    }
    // Right wall
    if (position.x + radius > game.width) {
      position.x = game.width - radius;
      if (velocity.x > 0) velocity.x = -velocity.x;
    }
  }

  /// Checks and handles collision with the bat.
  void _checkBatCollision() {
    final bat = _bat;
    if (bat == null) return;

    // Only check if ball is moving downward
    if (velocity.y <= 0) return;

    final collision = _getCircleRectCollision(
      circlePos: position,
      circleRadius: radius,
      rectPos: bat.position,
      rectSize: bat.size,
      rectAnchor: bat.anchor,
    );

    if (collision != null) {
      // Push ball out of bat
      position += collision.normal * collision.penetration;
      // Reflect velocity
      velocity.y = -velocity.y.abs();
    }
  }

  /// Checks and handles collision with the dynamic island block.
  void _checkBlockCollision() {
    final block = _block;
    if (block == null) return;

    // Respect collision cooldown
    if (_collisionCooldown > 0) return;

    final collision = _getCircleRectCollision(
      circlePos: position,
      circleRadius: radius,
      rectPos: block.position,
      rectSize: block.size,
      rectAnchor: block.anchor,
    );

    if (collision != null) {
      // Push ball out of block
      position += collision.normal * collision.penetration;

      // Reflect based on collision normal
      if (collision.normal.y.abs() > collision.normal.x.abs()) {
        // Vertical collision (top or bottom)
        velocity.y = -velocity.y;
      } else {
        // Horizontal collision (left or right)
        velocity.x = -velocity.x;
      }

      // Speed up
      const speedUpScale = 1.1;
      const maxSpeed = 800.0;
      if (velocity.length < maxSpeed) {
        velocity.scale(speedUpScale);
      }

      // Increment score
      ref.read(scoreProvider.notifier).increment();

      // Set cooldown
      _collisionCooldown = 0.2;
    }
  }

  /// Performs circle-rectangle collision detection.
  /// Returns collision info if colliding, null otherwise.
  ///
  /// [circlePos] - Center position of the circle.
  /// [circleRadius] - Radius of the circle.
  /// [rectPos] - Position of the rectangle (based on anchor).
  /// [rectSize] - Size of the rectangle.
  /// [rectAnchor] - Anchor point of the rectangle.
  _CollisionInfo? _getCircleRectCollision({
    required Vector2 circlePos,
    required double circleRadius,
    required Vector2 rectPos,
    required Vector2 rectSize,
    required Anchor rectAnchor,
  }) {
    // Calculate rect bounds (top-left corner)
    final rectLeft = rectPos.x - rectSize.x * rectAnchor.x;
    final rectTop = rectPos.y - rectSize.y * rectAnchor.y;
    final rectRight = rectLeft + rectSize.x;
    final rectBottom = rectTop + rectSize.y;

    // Find the closest point on the rectangle to the circle center
    final closestX = circlePos.x.clamp(rectLeft, rectRight);
    final closestY = circlePos.y.clamp(rectTop, rectBottom);

    // Calculate distance from circle center to closest point
    final dx = circlePos.x - closestX;
    final dy = circlePos.y - closestY;
    final distanceSquared = dx * dx + dy * dy;

    // Check if collision occurred
    if (distanceSquared >= circleRadius * circleRadius) {
      return null; // No collision
    }

    // Calculate collision normal and penetration depth
    final distance = math.sqrt(distanceSquared);

    Vector2 normal;
    double penetration;

    if (distance > 0) {
      // Circle center is outside the rectangle
      normal = Vector2(dx / distance, dy / distance);
      penetration = circleRadius - distance;
    } else {
      // Circle center is inside the rectangle - find nearest edge
      final distToLeft = circlePos.x - rectLeft;
      final distToRight = rectRight - circlePos.x;
      final distToTop = circlePos.y - rectTop;
      final distToBottom = rectBottom - circlePos.y;

      final minDistX = math.min(distToLeft, distToRight);
      final minDistY = math.min(distToTop, distToBottom);

      if (minDistX < minDistY) {
        // Push out horizontally
        if (distToLeft < distToRight) {
          normal = Vector2(-1, 0);
          penetration = distToLeft + circleRadius;
        } else {
          normal = Vector2(1, 0);
          penetration = distToRight + circleRadius;
        }
      } else {
        // Push out vertically
        if (distToTop < distToBottom) {
          normal = Vector2(0, -1);
          penetration = distToTop + circleRadius;
        } else {
          normal = Vector2(0, 1);
          penetration = distToBottom + circleRadius;
        }
      }
    }

    return _CollisionInfo(normal: normal, penetration: penetration);
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
}

/// Collision information containing normal and penetration depth.
class _CollisionInfo {
  _CollisionInfo({
    required this.normal,
    required this.penetration,
  });

  /// The collision normal pointing from the rectangle to the circle.
  final Vector2 normal;

  /// The penetration depth.
  final double penetration;
}
