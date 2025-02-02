import 'package:flutter/material.dart';

/// The settings overlay.
class Settings extends StatelessWidget {
  /// Creates a new settings overlay.
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'SETTINGS',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
