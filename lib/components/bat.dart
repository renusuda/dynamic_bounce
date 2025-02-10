import 'package:dynamic_bounce/dynamic_bounce_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
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
    if (!isMounted) {
      return;
    }
    final newPosition = _getNewXPosition(event.localDelta.x);
    position.x = newPosition;
  }

  /// Returns the new X position within the game width limit.
  double _getNewXPosition(double dx) {
    return (position.x + dx).clamp(
      0,
      game.width,
    );
  }
}
