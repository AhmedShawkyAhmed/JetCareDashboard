import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/constants/constants_methods.dart';
import 'package:jetboard/src/constants/end_points.dart';
import 'package:jetboard/src/data/data_provider/remote/dio_helper.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/data/network/responses/notification_response.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  static NotificationCubit get(context) => BlocProvider.of(context);

  NotificationResponse? notificationResponse;
  GlobalResponse? readNotificationResponse;
  bool isEmpty = false;

  Future getNotifications({
    required int userId,
  }) async {
    try {
      emit(GetNotificationLoadingState());
      await DioHelper.getData(url: EndPoints.getNotifications, query: {
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
      await DioHelper.getData(url: EndPoints.readNotification, query: {
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
      await DioHelper.postData(
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
      await DioHelper.postData(
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
      await DioHelper.postData(
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
