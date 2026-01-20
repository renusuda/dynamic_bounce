// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'DYNAMIC BOUNCE';

  @override
  String get play => 'PLAY';

  @override
  String get playAgain => 'PLAY AGAIN';

  @override
  String get newBestScoreMessage => 'ベストスコアを達成🎉';

  @override
  String get topRankingMessage => 'ランキング上位に到達しました🏆';

  @override
  String get rankingFetchErrorMessage => 'ランキングデータを取得できませんでした。あとでもう一度お試しください。';

  @override
  String get playerNameValidationMessage => '名前は1~8文字までです。';

  @override
  String get deleteAllTitle => 'データを削除';

  @override
  String get deleteDialogTitle => 'データを削除';

  @override
  String get deleteDialogContent => '本当にデータを削除しますか？\n削除されたデータは復元できません。';

  @override
  String get deleteDialogCancel => 'キャンセル';

  @override
  String get deleteDialogOk => '削除';

  @override
  String get accountDeletionSuccess => 'アカウントを削除できました。\nゲームをプレイしてくれてありがとうございます。\nまたいつかお会いしましょう😊';
}
