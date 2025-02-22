import 'package:flutter/material.dart';

/// The player overlay.
class Player extends StatelessWidget {
  /// Creates a new player overlay.
  const Player({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'PLAYER',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
