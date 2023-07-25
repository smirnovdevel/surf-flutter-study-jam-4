import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/core/logging.dart';

final Logging log = Logging('MagicState');

/// State ball
enum MagicState {
  normal,
  wait,
  result,
  error,
}

final magicStateProvider = StateProvider((_) => MagicState.normal);
