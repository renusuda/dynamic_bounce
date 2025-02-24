import 'package:dynamic_bounce/widgets/buttons/back_to_home_button.dart';
import 'package:flutter/material.dart';

/// Player overlay.
class Player extends StatelessWidget {
  /// Creates a new player overlay.
  const Player({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BackToHomeButton(),
        Text(
          'PLAYER',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
