import 'package:dynamic_bounce/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      leading: const Icon(Icons.delete_outlined),
      title: Text(
        l10n.deleteAllTitle,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
      onTap: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              l10n.deleteDialogTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            content: Text(
              l10n.deleteDialogContent,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: <Widget>[
              /// Cancel button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  l10n.deleteDialogCancel,
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
                  l10n.deleteDialogOk,
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
