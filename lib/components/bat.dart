import 'package:dynamic_bounce/dynamic_bounce_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

/// The bat of the game.
class Bat extends PositionComponent
    with DragCallbacks, HasGameReference<DynamicBounceGame> {
  /// Creates a new bat.
  Bat({
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          children: [
            RectangleHitbox(),
          ],
        );

  final Paint _paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Offset.zero & size.toSize(),
        const Radius.circular(5),
      ),
      _paint,
    );
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    if (game.playStatus == PlayStatus.playing) {
      final newPosition = _getNewXPosition(event.localDelta.x);
      position.x = newPosition;
    }
  }

  /// Moves the bat by a given horizontal offset with a smooth animation.
  void moveBy(double dx) {
    final x = _getNewXPosition(dx);
    final y = position.y;
    add(
      MoveToEffect(
        Vector2(x, y),
        EffectController(duration: 0.1),
      ),
    );
  }

  /// Returns the new X position within the game width limit.
  double _getNewXPosition(double dx) {
    return (position.x + dx).clamp(
      0,
      game.width,
    );
  }
}
