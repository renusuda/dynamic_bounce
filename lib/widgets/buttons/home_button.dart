import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:dynamic_bounce/providers/score.dart';
import 'package:dynamic_bounce/widgets/buttons/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The home button.
class HomeButton extends ConsumerWidget {
  /// Creates a new home button.
  const HomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonButton(
      icon: Icons.home_outlined,
      onPressed: () {
        // Reset the score to 0 and navigate to the home overlay again.
        ref.read(scoreProvider.notifier).reset();
        ref
            .read(playStatusProvider.notifier)
            .updatePlayStatus(PlayStatusType.home);
      },
    );
  }
}
