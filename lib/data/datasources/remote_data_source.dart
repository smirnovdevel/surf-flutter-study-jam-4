import '../../utils/core/logging.dart';
import '../web/http_service.dart';

final Logging log = Logging('RemoteDataSource');

class RemoteDataSource {
  RemoteDataSource(this.web);
  final HttpService web;

  Future<String> getMagic() async {
    log.debug('Get magic ...');
    String magic = await web.getmagic();
    log.debug('Get magic: $magic');
    return magic;
  }
}
