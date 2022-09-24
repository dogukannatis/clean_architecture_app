
import 'package:clean_architecture_app/data/network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorized,
  notFound,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  defaultError
}

extension DataSourceExtention on DataSource{
  Failure getFailure(){
    switch(this){
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unAuthorized:
        return Failure(ResponseCode.unAuthorized, ResponseMessage.unAuthorized);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError, ResponseMessage.internalServerError);
      case DataSource.connectTimeout:
        return Failure(ResponseCode.connectTimeout, ResponseMessage.connectTimeout);
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
      case DataSource.receiveTimeout:
        return Failure(ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection, ResponseMessage.noInternetConnection);
      case DataSource.defaultError:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
      default:
        return Failure(ResponseCode.defaultError, ResponseMessage.defaultError);
    }
  }
}


class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error){
    if(error is DioError){
      failure = _handleError(error);
    }else{
      failure = DataSource.defaultError.getFailure();
    }
  }

  Failure _handleError(DioError error){
    switch(error.type){
      case DioErrorType.connectTimeout:
        return DataSource.connectTimeout.getFailure();

      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();

      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();

      case DioErrorType.response:
         switch(error.response?.statusCode){
           case ResponseCode.badRequest:
             return DataSource.badRequest.getFailure();
           case ResponseCode.forbidden:
             return DataSource.forbidden.getFailure();
           case ResponseCode.unAuthorized:
             return DataSource.unAuthorized.getFailure();
           case ResponseCode.notFound:
             return DataSource.notFound.getFailure();
           case ResponseCode.internalServerError:
             return DataSource.internalServerError.getFailure();
           default:
             return DataSource.defaultError.getFailure();
         }

      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();

      case DioErrorType.other:
        return DataSource.defaultError.getFailure();

      default:
        return DataSource.defaultError.getFailure();
    }
  }


}


/// API and Local status codes.
class ResponseCode {
  // API Status Codes

  /// Success with data
  static const int success = 200;
  /// Success with no content
  static const int noContent = 201;
  /// Failure, API rejected the request
  static const int badRequest = 400;
  /// Failure, API rejected the request
  static const int forbidden = 403;
  /// Failure, user is not authorised
  static const int  unAuthorized = 401;
  /// Failure, API url is not correct and not found
  static const int  notFound = 404;
  /// Failure, crash happened in server side
  static const int internalServerError = 500;

  // Local Status Codes
  static const int  defaultError = -1;
  static const int  connectTimeout = -2;
  static const int  cancel = -3;
  static const int  receiveTimeout = -4;
  static const int  sendTimeout = -5;
  static const int  cacheError = -6;
  static const int  noInternetConnection = -7;
}

/// API and Local status messages.
class ResponseMessage {
  // API Status Codes

  /// Success with data
  static const String success = "Success";
  /// Success with no content
  static const String noContent = "Success with no content";
  /// Failure, API rejected the request
  static const String badRequest = "Bad request, try again later";
  /// Failure, API rejected the request
  static const String forbidden = "Forbidden request, try again later";
  /// Failure, user is not authorised
  static const String  unAuthorized = "User is unauthorized, try again later";
  /// Failure, API url is not correct and not found
  static const String  notFound = "URL is not found, try again later";
  /// Failure, crash happened in server side
  static const String internalServerError = "Something went wrong, try again later";

  // Local Status Codes
  static const String  defaultError = "Something went wrong, try again later";
  static const String  connectTimeout = "Timeout error, try again later";
  static const String  cancel = "Request was cancelled, try again later";
  static const String  receiveTimeout = "Timeout error, try again later";
  static const String  sendTimeout = "Timeout error, try again later";
  static const String  cacheError = "Cache error, try again later";
  static const String  noInternetConnection = "Please check your internet connection";
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}