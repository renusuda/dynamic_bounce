import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:dynamic_bounce/widgets/buttons/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The ranking button.
class RankingButton extends ConsumerWidget {
  /// Creates a new ranking button.
  const RankingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonButton(
      icon: Icons.emoji_events_outlined,
      onPressed: () {
        ref
            .read(playStatusProvider.notifier)
            .updatePlayStatus(PlayStatusType.ranking);
      },
    );
  }
}
