import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/remote_data_source.dart';
import 'data/web/http_service.dart';
import 'domain/repositories/magic_repository.dart';
import 'utils/core/logging.dart';

final Logging log = Logging('DI');

abstract class DI {
  static final _locator = GetIt.instance;

  static MagicRepository get todoRepository => _locator<MagicRepository>();

  static Future<void> initializeDependencies() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// Repository Todos
    _locator.registerLazySingleton<MagicRepository>(
      () => MagicRepository(
        remoteDataSource: _locator(),
      ),
    );

    /// Source data
    _locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(_locator()),
    );

    // External
    _locator.registerLazySingleton<HttpService>(() => HttpService());
  }
}
