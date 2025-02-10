import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score.g.dart';

/// play status provider
@riverpod
class Score extends _$Score {
  @override
  int build() => 0;

  /// update play status
  /// ignore: use_setters_to_change_properties
  void increment() => state++;
}
