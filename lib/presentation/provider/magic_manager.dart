import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/utils/core/logging.dart';

import '../../di.dart';
import '../../domain/repositories/magic_repository.dart';
import '../../utils/exceptions/exception.dart';
import 'magic_notifer_provider.dart';
import 'magic_state_provider.dart';

final Logging log = Logging('MagicManager');

final Provider magicManagerProvider = Provider(
  (ref) => MagicManager(
    ref.watch(magicNotiferProvider.notifier),
    ref,
  ),
);

class MagicManager {
  final MagicStateHolder _message;
  final Ref _ref;

  MagicManager(this._message, this._ref);
  final MagicRepository _magicService = DI.todoRepository;

  Future<void> getMagic() async {
    _ref.read(magicStateProvider.notifier).state = MagicState.wait;
    _message.init(magic: '');
    log.debug('Wait magic ...');

    String magic = '';
    try {
      magic = await _magicService.getmagic();
      _ref.read(magicStateProvider.notifier).state = MagicState.result;
    } on ServerException catch (ex) {
      log.warning(ex.toString());
      _ref.read(magicStateProvider.notifier).state = MagicState.error;
      magic = ex.toString();
    } catch (e) {
      log.warning(e.toString());
      _ref.read(magicStateProvider.notifier).state = MagicState.error;
      magic = e.toString();
    }
    _message.init(magic: magic);
    log.debug('Magic get: $magic');
  }
}
