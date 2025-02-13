import 'package:flutter/material.dart';

/// A reusable button widget.
class CommonButton extends StatelessWidget {
  /// Creates a new common button.
  const CommonButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  /// The icon.
  final IconData icon;

  /// the callback when the button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 72,
      onPressed: onPressed,
    );
  }
}
