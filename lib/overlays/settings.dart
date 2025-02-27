import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:dynamic_bounce/providers/play_status.dart';
import 'package:dynamic_bounce/providers/player.dart';
import 'package:dynamic_bounce/widgets/buttons/back_to_home_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The settings overlay.
class Settings extends StatelessWidget {
  /// Creates a new settings overlay.
  const Settings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BackToHomeButton(),
        DeleteAllListTile(),
      ],
    );
  }
}

/// Data deletion row
class DeleteAllListTile extends ConsumerWidget {
  /// Constructor
  const DeleteAllListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: const Icon(Icons.delete_outlined),
      title: Text(
        'Delete all data',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              'Delete all data',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text(
              '''Are you sure you want to delete data?\nDeleted data cannot be restored.''',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: <Widget>[
              /// Cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),

              /// Delete button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(playerProvider.notifier).deleteAll();
                  ref
                      .read(playStatusProvider.notifier)
                      .updatePlayStatus(PlayStatusType.deleted);
                },
                child: Text(
                  'Delete',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
