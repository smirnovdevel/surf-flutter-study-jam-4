import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/core/logging.dart';

final Logging log = Logging('MagicNotiferProvider');

final magicNotiferProvider = StateNotifierProvider<MagicStateHolder, String?>(
  (ref) => MagicStateHolder(),
);

class MagicStateHolder extends StateNotifier<String?> {
  MagicStateHolder([String? empty]) : super(empty);

  void init({required String magic}) {
    log.debug('Loaded');
    state = magic;
  }
}
