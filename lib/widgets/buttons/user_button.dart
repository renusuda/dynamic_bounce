import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:dynamic_bounce/widgets/buttons/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The user button.
class UserButton extends ConsumerWidget {
  /// Creates a new user button.
  const UserButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonButton(
      icon: Icons.account_circle_outlined,
      onPressed: () {
        ref
            .read(playStatusProvider.notifier)
            .updatePlayStatus(PlayStatusType.user);
      },
    );
  }
}
