import 'package:flutter/material.dart';

/// The settings overlay.
class Settings extends StatelessWidget {
  /// Creates a new settings overlay.
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'SETTINGS',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
