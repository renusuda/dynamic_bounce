import 'package:flutter/material.dart';

/// A reusable button with text widget.
class CommonTextButton extends StatelessWidget {
  /// Creates a new common text button.
  const CommonTextButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  /// The text.
  final String text;

  /// The icon.
  final IconData icon;

  /// the callback when the button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        IconButton(
          icon: Icon(icon),
          iconSize: 72,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
