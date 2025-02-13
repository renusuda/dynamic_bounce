import 'package:dynamic_bounce/widgets/buttons/common_button.dart';
import 'package:flutter/material.dart';

/// The home button.
class HomeButton extends StatelessWidget {
  /// Creates a new home button.
  const HomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      icon: Icons.home_outlined,
      onPressed: () {},
    );
  }
}
