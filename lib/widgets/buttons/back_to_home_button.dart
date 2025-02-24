import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Back button to return to home.
class BackToHomeButton extends ConsumerWidget {
  /// Creates a new back to home button.
  const BackToHomeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Align(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 30,
          onPressed: () {
            ref
                .read(playStatusProvider.notifier)
                .updatePlayStatus(PlayStatusType.home);
          },
        ),
      ),
    );
  }
}
