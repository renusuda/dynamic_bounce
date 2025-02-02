import 'package:flutter/material.dart';

/// The ranking overlay.
class Ranking extends StatelessWidget {
  /// Creates a new ranking overlay.
  const Ranking({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'RANKING',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
