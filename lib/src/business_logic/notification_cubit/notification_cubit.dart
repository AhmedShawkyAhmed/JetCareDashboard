import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/data/network/responses/notification_response.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.networkService) : super(NotificationInitial());
  NetworkService networkService;
  static NotificationCubit get(context) => BlocProvider.of(context);

  NotificationResponse? notificationResponse;
  GlobalResponse? readNotificationResponse;
  bool isEmpty = false;

  Future getNotifications({
    required int userId,
  }) async {
    try {
      emit(GetNotificationLoadingState());
      await networkService.get(url: EndPoints.getNotifications, query: {
        "userId": userId,
      }).then((value) {
        notificationResponse = NotificationResponse.fromJson(value.data);
        printResponse(value.data.toString());
        if(value.data['status'] == 404){
          isEmpty = true;
        }
        emit(GetNotificationSuccessState());
      });
    } on DioError catch (n) {
      emit(GetNotificationErrorState());
      printError(n.toString());
    } catch (e) {
      emit(GetNotificationErrorState());
      printError(e.toString());
    }
  }

  Future readNotification({
    required int id,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(ReadNotificationLoadingState());
      await networkService.get(url: EndPoints.readNotification, query: {
        "id": id,
      }).then((value) {
        printResponse(value.data.toString());
        readNotificationResponse = GlobalResponse.fromJson(value.data);
        emit(ReadNotificationSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(ReadNotificationErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ReadNotificationErrorState());
      printError(e.toString());
    }
  }

  Future notifyUser({
    required int id,
    required String title,
    required String message,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(SendNotificationLoadingState());
      await networkService.post(
        url: EndPoints.notifyUser,
        body: {
          'id': id,
          'title': title,
          'message': message,
        },
      ).then((value) {
        printResponse(value.data.toString());
        emit(SendNotificationSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(SendNotificationErrorState());
      printError(n.toString());
    } catch (e) {
      emit(SendNotificationErrorState());
      printError(e.toString());
    }
  }

  Future notifyAll({
    required String title,
    required String message,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(SendNotificationLoadingState());
      await networkService.post(
        url: EndPoints.notifyAll,
        body: {
          'title': title,
          'message': message,
        },
      ).then((value) {
        printResponse(value.data.toString());
        emit(SendNotificationSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(SendNotificationErrorState());
      printError(n.toString());
    } catch (e) {
      emit(SendNotificationErrorState());
      printError(e.toString());
    }
  }

  Future saveNotification({
    required int id,
    required String title,
    required String message,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(SaveNotificationLoadingState());
      await networkService.post(
        url: EndPoints.saveNotification,
        body: {
          'userId': id,
          'title': title,
          'message': message,
        },
      ).then((value) {
        printResponse(value.data.toString());
        emit(SaveNotificationSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(SaveNotificationErrorState());
      printError(n.toString());
    } catch (e) {
      emit(SaveNotificationErrorState());
      printError(e.toString());
    }
  }
}
