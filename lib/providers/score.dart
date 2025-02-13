import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score.g.dart';

/// score provider
@riverpod
class Score extends _$Score {
  @override
  int build() => 0;

  /// update score
  /// ignore: use_setters_to_change_properties
  void increment() => state++;

  /// reset score
  void reset() => state = 0;
}
