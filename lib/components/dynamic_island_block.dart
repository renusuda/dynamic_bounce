import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';

/// The block under dynamic island.
class DynamicIslandBlock extends PositionComponent with RiverpodComponentMixin {
  /// Creates a new block under dynamic island.
  DynamicIslandBlock({
    required super.position,
  }) : super(
          size: Vector2(130, 28),
          anchor: Anchor.center,
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
        const Radius.circular(20),
      ),
      _paint,
    );
  }
}
