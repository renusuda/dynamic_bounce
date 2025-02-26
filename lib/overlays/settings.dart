import 'package:dynamic_bounce/widgets/buttons/back_to_home_button.dart';
import 'package:flutter/material.dart';

/// The settings overlay.
class Settings extends StatelessWidget {
  /// Creates a new settings overlay.
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BackToHomeButton(),
        Text(
          'SETTINGS',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
