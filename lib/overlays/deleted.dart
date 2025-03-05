import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Account deleted overlay.
class Deleted extends StatelessWidget {
  /// Creates a new account deleted overlay.
  const Deleted({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          l10n.accountDeletionSuccess,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
