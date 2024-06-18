import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/shared/widgets/toast.dart';

import 'network_base_model.dart';

part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const NetworkExceptions._();

  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(NetworkBaseModel response) =
      DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  const factory NetworkExceptions.resetPasswordInvalidEmail(String reason) =
      ResetPasswordInvalidEmail;

  const factory NetworkExceptions.emailIsAlreadyExists() = EmailIsAlreadyExists;

  static NetworkExceptions handleResponse(Response? response) {
    NetworkBaseModel res = NetworkBaseModel.fromJson(
        response?.data, (json) => json as Map<String, dynamic>?);
    String errorMessage = res.message;
    if (response?.statusCode != null && response?.statusCode != 200) {
      int statusCode = response!.statusCode!;
      switch (statusCode) {
        case 401:
          return NetworkExceptions.unauthorizedRequest(errorMessage);
        case 403:
          return NetworkExceptions.unauthorizedRequest(errorMessage);
        case 404:
          return NetworkExceptions.notFound(errorMessage);
        case 409:
          return const NetworkExceptions.conflict();
        case 408:
          return const NetworkExceptions.requestTimeout();
        case 500:
          return const NetworkExceptions.internalServerError();
        case 503:
          return const NetworkExceptions.serviceUnavailable();
        default:
          return NetworkExceptions.defaultError(res..status = statusCode);
      }
    } else {
      return handleCustomResponse(res);
    }
  }

  static NetworkExceptions handleCustomResponse(NetworkBaseModel response) {
    response.message;
    return NetworkExceptions.defaultError(response);
  }

  static NetworkExceptions getException(dynamic error) {
    printError(error, runtimeType: NetworkExceptions);
    if (error is Exception) {
      try {
        late NetworkExceptions networkExceptions;
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.unknown:
              if (error.error.toString().contains('Failed host lookup') ==
                  true) {
                networkExceptions =
                    const NetworkExceptions.noInternetConnection();
              } else {
                networkExceptions = const NetworkExceptions.unexpectedError();
              }
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkExceptions =
                  NetworkExceptions.handleResponse(error.response);
              break;
            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badCertificate:
              networkExceptions = const NetworkExceptions.notAcceptable();
              break;
            case DioExceptionType.connectionError:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    }
    //  else if (error is NetworkBaseModel) {
    //   return NetworkExceptions.handleBeTrendResponse(,rror);
    // }
    else {
      if (error.toString().contains("is not a subtype of")) {
        printError(error.toString());
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  /// Localized error message.
  String get message {
    var errorMessage = "";
    when(notImplemented: () {
      errorMessage = 'لم تنفذ العملية';
    }, requestCancelled: () {
      errorMessage = "تم إلغاء الطلب";
    }, internalServerError: () {
      errorMessage = "خطأ في الخادم الداخلي";
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: () {
      errorMessage = "الخدمة غير متوفرة";
    }, methodNotAllowed: () {
      errorMessage = "حدث خطأ غير متوقع";
    }, badRequest: () {
      errorMessage = "حدث خطأ غير متوقع";
    }, unauthorizedRequest: (String error) {
      errorMessage = 'انتهت صلاحية الجلسة، برجاء إعادة تسجيل الدخول';
    }, unexpectedError: () {
      errorMessage = "خطأ غير معروف";
    }, requestTimeout: () {
      errorMessage = "انتهى وقت محاولة الاتصال";
    }, noInternetConnection: () {
      errorMessage = "لا يوجد اتصال بالإنترنت";
    }, conflict: () {
      errorMessage = '';
    }, sendTimeout: () {
      errorMessage = "انتهى وقت محاولة الاتصال";
    }, unableToProcess: () {
      errorMessage = 'فشل معالجة البيانات';
    }, defaultError: (NetworkBaseModel response) {
      errorMessage = response.message;
    }, formatException: () {
      errorMessage = "خطأ غير معروف";
    }, notAcceptable: () {
      errorMessage = "حدث خطأ غير متوقع";
    }, resetPasswordInvalidEmail: (String reason) {
      errorMessage = reason;
    }, emailIsAlreadyExists: () {
      errorMessage = "هذا البريد الإلكتروني مسجل بالفعل";
    });
    return errorMessage;
  }

  void showError() {
    var errorMessage = message;
    DefaultToast.showMyToast(errorMessage);
  }
}
