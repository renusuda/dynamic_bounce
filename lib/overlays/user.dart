import 'package:flutter/material.dart';

/// The user overlay.
class User extends StatelessWidget {
  /// Creates a new user overlay.
  const User({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'USER',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
