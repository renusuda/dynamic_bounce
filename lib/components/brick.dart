import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

// TODO(me): Update this class to dynamic island.
/// The brick of the game.
class Brick extends PositionComponent {
  /// Creates a new brick.
  Brick({
    required super.position,
  }) : super(
          size: Vector2(120, 35),
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
        const Radius.circular(25),
      ),
      _paint,
    );
  }
}
