import 'package:dynamic_bounce/dynamic_bounce_game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The game provider.
final gameProvider = Provider(
  (ref) => DynamicBounceGame(),
);

/// The game widget key.
final gameWidgetKey = GlobalKey<RiverpodAwareGameWidgetState>();
