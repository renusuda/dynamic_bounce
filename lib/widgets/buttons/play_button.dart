import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:dynamic_bounce/widgets/buttons/common_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The play button.
class PlayButton extends ConsumerWidget {
  /// Creates a new play button.
  const PlayButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    return CommonTextButton(
      text: l10n.play,
      icon: Icons.play_circle_outline,
      onPressed: () {
        ref
            .read(playStatusProvider.notifier)
            .updatePlayStatus(PlayStatusType.playing);
      },
    );
  }
}
