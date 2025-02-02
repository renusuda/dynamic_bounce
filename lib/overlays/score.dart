import 'package:flutter/material.dart';

/// The score overlay.
class Score extends StatelessWidget {
  /// Creates a new score overlay.
  const Score({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'SCORE',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
