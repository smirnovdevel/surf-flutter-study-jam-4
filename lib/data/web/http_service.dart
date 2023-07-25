import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:surf_practice_magic_ball/common/app_urls.dart';

import '../../utils/core/logging.dart';
import '../../utils/exceptions/exception.dart';
import 'web_service.dart';

final Logging log = Logging('HttpService');

final InternetConnectionChecker customInstance =
    InternetConnectionChecker.createInstance(
  checkTimeout: const Duration(seconds: 2),
  checkInterval: const Duration(seconds: 2),
);

class HttpService implements IWebService {
  bool isConnected = true;

  /// Check internet connection
  ///
  Future<bool> execute(
    InternetConnectionChecker internetConnectionChecker,
  ) async {
    return await internetConnectionChecker.hasConnection;
  }

  /// Get Fortune from Server
  ///
  @override
  Future<String> getmagic() async {
    String magic = '';
    if (!kIsWeb) {
      isConnected = await execute(customInstance);
      if (!isConnected) {
        throw const ServerException('no_internet');
      }
    }
    var url = Uri.parse(AppUrls.magic);
    log.debug('Get magic from: $url ...');

    try {
      final http.Response response = await http.get(url).timeout(
        const Duration(seconds: 1),
        onTimeout: () {
          throw const ServerException('Server timeout error');
        },
      );
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        log.debug('Get magic, result: $result');
        magic = result['reading'];
        log.debug('Get magic: $magic');
      } else {
        log.debug('Get magic, response code: ${response.statusCode}');
        throw ServerException(response.statusCode.toString());
      }
    } on HttpException catch (e) {
      log.warning('Get magic: Http error! STATUS: ${e.message}');
    } on TimeoutException catch (e) {
      log.warning('Get magic: Timeout error! STATUS: ${e.message}');
    } on SocketException catch (e) {
      log.warning('Get magic: Socket error! STATUS: ${e.message}');
    }
    return magic;
  }
}
