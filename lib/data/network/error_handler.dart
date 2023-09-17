import 'package:dio/dio.dart';
import 'package:tut_app/data/network/failure.dart';

import '../../presentation/resources/Strings_Manger.dart';

class ErrorHandler implements Exception {

  late Failure failure;

  ErrorHandler.handle(dynamic error){
    if (error is DioException) {
      failure = _handleError(error: error);
    } else {
      failure = DataSource.DEFAULT.getFailure();
    }
  }

}

Failure _handleError({required DioException error}) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();

    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badResponse:
      if (error.response!.statusMessage != null &&
          error.response!.statusCode != null) {
        return Failure(message: error.response!.statusMessage,
            statusCode: error.response!.statusCode);
      } else {
        return DataSource.DEFAULT.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.unknown:
      return DataSource.DEFAULT.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.INTERNAL_SERVER_ERROR.getFailure();

    case DioExceptionType.connectionError:
      return DataSource.NO_INTERNET_CONNECTION.getFailure();
  }
}


enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return const Failure(
            statusCode: ResponseCode.SUCCESS, message: ResponseMessage.SUCCESS);
      case DataSource.NO_CONTENT:
        return const Failure(
            statusCode: ResponseCode.NO_CONTENT,
            message: ResponseMessage.NO_CONTENT);
      case DataSource.BAD_REQUEST:
        return const Failure(
            statusCode: ResponseCode.BAD_REQUEST,
            message: ResponseMessage.BAD_REQUEST);
      case DataSource.FORBIDDEN:
        return const Failure(statusCode: ResponseCode.FORBIDDEN,
            message: ResponseMessage.FORBIDDEN);
      case DataSource.UNAUTORISED:
        return const Failure(
            statusCode: ResponseCode.UNAUTORISED,
            message: ResponseMessage.UNAUTORISED);
      case DataSource.NOT_FOUND:
        return const Failure(statusCode: ResponseCode.NOT_FOUND,
            message: ResponseMessage.NOT_FOUND);
      case DataSource.INTERNAL_SERVER_ERROR:
        return const Failure(statusCode: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessage.INTERNAL_SERVER_ERROR);
      case DataSource.CONNECT_TIMEOUT:
        return const Failure(
            statusCode: ResponseCode.CONNECT_TIMEOUT,
            message: ResponseMessage.CONNECT_TIMEOUT);
      case DataSource.CANCEL:
        return const Failure(
            statusCode: ResponseCode.CANCEL, message: ResponseMessage.CANCEL);
      case DataSource.RECIEVE_TIMEOUT:
        return const Failure(
            statusCode: ResponseCode.RECIEVE_TIMEOUT,
            message: ResponseMessage.RECIEVE_TIMEOUT);
      case DataSource.SEND_TIMEOUT:
        return const Failure(
            statusCode: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessage.SEND_TIMEOUT);
      case DataSource.CACHE_ERROR:
        return const Failure(
            statusCode: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR);
      case DataSource.NO_INTERNET_CONNECTION:
        return const Failure(statusCode: ResponseCode.NO_INTERNET_CONNECTION,
            message: ResponseMessage.NO_INTERNET_CONNECTION);
      case DataSource.DEFAULT:
        return const Failure(
            statusCode: ResponseCode.DEFAULT, message: ResponseMessage.DEFAULT);
    }
  }
}


class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static const String SUCCESS = AppString.success; // success with data
  static const String NO_CONTENT =
      AppString.success; // success with no data (no content)
  static const String BAD_REQUEST =
      AppString.badRequestError; // failure, API rejected request
  static const String UNAUTORISED =
      AppString.unauthorizedError; // failure, user is not authorised
  static const String FORBIDDEN =
      AppString.forbiddenError; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      AppString.internalServerError; // failure, crash in server side
  static const String NOT_FOUND =
      AppString.notFoundError; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = AppString.timeoutError;
  static const String CANCEL = AppString.defaultError;
  static const String RECIEVE_TIMEOUT = AppString.timeoutError;
  static const String SEND_TIMEOUT = AppString.timeoutError;
  static const String CACHE_ERROR = AppString.cacheError;
  static const String NO_INTERNET_CONNECTION = AppString.noInternetError;
  static const String DEFAULT = AppString.defaultError;
}
class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}