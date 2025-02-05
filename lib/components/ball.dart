import 'package:dynamic_bounce/components/bat.dart';
import 'package:dynamic_bounce/components/brick.dart';
import 'package:dynamic_bounce/components/play_area.dart';
import 'package:dynamic_bounce/dynamic_bounce_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

/// A ball that bounces around the screen.
class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<DynamicBounceGame> {
  /// Creates a new ball.
  Ball({
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

      final isTopWallCollision = intersectionPoint.y <= 0;
      final isLeftWallCollision = intersectionPoint.x <= 0;
      final isRightWallCollision = intersectionPoint.x >= game.width;
      final isBottomWallCollision = intersectionPoint.y >= game.height;
      if (isTopWallCollision || isBottomWallCollision) {
        add(
          RemoveEffect(
            delay: 0.35,
            onComplete: () {
              game.playStatus = PlayStatus.score;
            },
          ),
        );
      } else if (isLeftWallCollision || isRightWallCollision) {
        velocity.x = -velocity.x;
      }
    } else if (other is Bat) {
      // To-do: Adjust the way the ball bounces off the bat so that the user can
      // have some control over its direction.
      velocity
        ..x = velocity.x +
            (position.x - other.position.x) / other.size.x * game.width * 0.3
        ..y = -velocity.y;
    } else if (other is Brick) {
      // TODO(me): Adjust the way the ball bounces off the brick so that the
      // user can have some control over its direction.
      const speedUpScale = 1.05;
      velocity
        ..x = -velocity.x * speedUpScale
        ..y = velocity.y +
            (position.y - other.position.y) /
                other.size.y *
                game.width *
                0.3 *
                speedUpScale;
    }
  }
}
