import 'package:flutter_riverpod/flutter_riverpod.dart';

class MuteNotifier extends StateNotifier<bool> {
  MuteNotifier() : super(false);

  update(bool mute) {
    state = mute;
  }
}

final muteProvider = StateNotifierProvider<MuteNotifier, bool>((ref) {
  return MuteNotifier();
});
