import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:dynamic_bounce/providers/score.dart';
import 'package:dynamic_bounce/widgets/buttons/common_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The play again button.
class PlayAgainButton extends ConsumerWidget {
  /// Creates a new play again button.
  const PlayAgainButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonTextButton(
      text: 'PLAY AGAIN',
      icon: Icons.replay,
      onPressed: () {
        // Reset the score to 0 and navigate to the playing overlay again.
        ref.read(scoreProvider.notifier).reset();
        ref
            .read(playStatusProvider.notifier)
            .updatePlayStatus(PlayStatusType.playing);
      },
    );
  }
}
