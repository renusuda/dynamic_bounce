import 'package:dynamic_bounce/widgets/buttons/common_text_button.dart';
import 'package:flutter/material.dart';

/// The play again button.
class PlayAgainButton extends StatelessWidget {
  /// Creates a new play again button.
  const PlayAgainButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTextButton(
      text: 'PLAY AGAIN',
      icon: Icons.replay,
      onPressed: () {},
    );
  }
}
