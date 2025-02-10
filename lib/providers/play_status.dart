import 'package:dynamic_bounce/models/play_status_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_status.g.dart';

/// play status provider
@riverpod
class PlayStatus extends _$PlayStatus {
  @override
  PlayStatusType build() => PlayStatusType.home;

  /// update play status
  /// ignore: use_setters_to_change_properties
  void updatePlayStatus(PlayStatusType playStatusType) {
    state = playStatusType;
  }
}
