import '../../data/datasources/remote_data_source.dart';
import '../../utils/core/logging.dart';

final Logging log = Logging('MagicRepository');

class MagicRepository {
  final RemoteDataSource remoteDataSource;

  MagicRepository({
    required this.remoteDataSource,
  });

  Future<String> getmagic() async {
    String magic = await remoteDataSource.getMagic();
    log.debug('Get magic: $magic');
    return magic;
  }
}
