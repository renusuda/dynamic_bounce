import 'package:dynamic_bounce/dynamic_bounce_game.dart';
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
        );

  final Paint _paint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill;

  /// Extra padding around the bat for easier drag detection.
  static const double dragPadding = 100;

  @override
  bool containsLocalPoint(Vector2 point) {
    return point.x >= -dragPadding &&
        point.x <= size.x + dragPadding &&
        point.y >= -dragPadding &&
        point.y <= size.y + dragPadding;
  }

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
    final newXPosition = _getNewXPosition(event.localDelta.x);
    final newYPosition = _getNewYPosition(event.localDelta.y);
    position
      ..x = newXPosition
      ..y = newYPosition;
  }

  /// Returns the new X position within the game width limit.
  double _getNewXPosition(double dx) {
    return (position.x + dx).clamp(
      0,
      game.width,
    );
  }

  /// Returns a new Y position within the lower half of the game screen
  /// that doesn't overlap the score text.
  double _getNewYPosition(double dy) {
    final upperLimit = game.height * 0.5;
    final lowerLimit = game.height * 0.925;
    return (position.y + dy).clamp(
      upperLimit,
      lowerLimit,
    );
  }
}
