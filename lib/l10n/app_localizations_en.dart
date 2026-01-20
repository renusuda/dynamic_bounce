// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DYNAMIC BOUNCE';

  @override
  String get play => 'PLAY';

  @override
  String get playAgain => 'PLAY AGAIN';

  @override
  String get newBestScoreMessage => 'New Best Score🎉';

  @override
  String get topRankingMessage => 'You\'re in the top rankings🏆';

  @override
  String get rankingFetchErrorMessage => 'We couldn\'t fetch ranking data. Please try again later.';

  @override
  String get playerNameValidationMessage => 'Please enter a name between 1 and 8 characters.';

  @override
  String get deleteAllTitle => 'Delete all data';

  @override
  String get deleteDialogTitle => 'Delete all data';

  @override
  String get deleteDialogContent => 'Are you sure you want to delete data?\nDeleted data cannot be restored.';

  @override
  String get deleteDialogCancel => 'Cancel';

  @override
  String get deleteDialogOk => 'Delete';

  @override
  String get accountDeletionSuccess => 'Your account has been successfully deleted.\nThank you for playing our game.\nWe hope to see you again in the future.😊';
}
