import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/constance.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  final AppPreferences appPreferences;

  DioFactory({required this.appPreferences});

  Future<Dio> getDio() async {
    final dio = Dio();
    String language = await appPreferences.getAppLanguage();
    Map<String, String> header = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constance.token,
      DEFAULT_LANGUAGE: language,
    };

    dio.options = BaseOptions(
      baseUrl: Constance.baseUrl,
      headers: header,
      receiveTimeout: const Duration(seconds: Constance.apiTimeOut),
      sendTimeout: const Duration(seconds: Constance.apiTimeOut),
    );
    if (!kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
