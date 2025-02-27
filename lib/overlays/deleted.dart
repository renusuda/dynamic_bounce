import 'package:flutter/material.dart';

/// Account deleted overlay.
class Deleted extends StatelessWidget {
  /// Creates a new account deleted overlay.
  const Deleted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          '''Your account has been successfully deleted.\nThank you for playing our game.\nWe hope to see you again in the future.😊''',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
