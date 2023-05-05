import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jetboard/src/data/models/orders_model.dart';
import 'package:jetboard/src/data/network/requests/order_request.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import '../../constants/constants_methods.dart';
import '../../constants/end_points.dart';
import '../../data/data_provider/remote/dio_helper.dart';
import '../../data/network/responses/orders_response.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  static OrdersCubit get(context) => BlocProvider.of(context);
  OrdersResponse? getOrdersResponse, updateOrdersStatusResponse;
  GlobalResponse? globalResponse, orderResponse;
  List<OrdersModel> ordersList = [];
  int listCount = 0;
  int index = 0;

  Future getOrders({
    String? keyword,
    type,
  }) async {
    ordersList.clear();
    listCount = 0;
    getOrdersResponse = null;
    try {
      emit(OrdersLodingState());
      await DioHelper.getData(
        url: EndPoints.getOrders,
        query: {
          "keyword": keyword,
          "type": type,
        },
      ).then((value) {
        printSuccess(value.data.toString());
        getOrdersResponse = OrdersResponse.fromJson(value.data);
        ordersList.addAll(getOrdersResponse!.ordersModel!);
        listCount = getOrdersResponse!.ordersModel!.length;
        emit(OrdersSuccessState());
      });
    } on DioError catch (n) {
      emit(OrdersErrorState());
      printError(n.toString());
    } catch (e) {
      emit(OrdersErrorState());
      printError(e.toString());
    }
  }

  Future assignOrder({
    required int id,
    required int crewId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(AssignOrdersLodingState());
      await DioHelper.postData(
        url: EndPoints.assignOrder,
        body: {
          'id': id,
          'crewId': crewId,
        },
      ).then((value) {
        updateOrdersStatusResponse = OrdersResponse.fromJson(value.data);
        getOrders();
        afterSuccess();
        emit(AssignOrdersSuccessState());
      });
    } on DioError catch (n) {
      emit(AssignOrdersErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AssignOrdersErrorState());
      printError(e.toString());
    }
  }

  Future deleteOrder({
    required int orderId,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(DeleteOrderStatusLoadingState());
      await DioHelper.postData(url: EndPoints.deleteOrder, body: {
        'id': orderId,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        DefaultToast.showMyToast(globalResponse!.message.toString());
        getOrders();
        printSuccess(
            "Delete Order Response ${globalResponse!.message.toString()}");
        emit(DeleteOrderStatusSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(DeleteOrderStatusErrorState());
      printError(n.toString());
    } catch (e) {
      emit(DeleteOrderStatusErrorState());
      printError(e.toString());
    }
  }

  Future updateOrderStatus({
    required int orderId,
    required String status,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(UpdateOrderStatusLoadingState());
      await DioHelper.postData(url: EndPoints.updateOrderStatus, body: {
        'id': orderId,
        'status': status,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        DefaultToast.showMyToast(globalResponse!.message.toString());
        printSuccess(
            "Update Order Response ${globalResponse!.message.toString()}");
        emit(UpdateOrderStatusSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(UpdateOrderStatusErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateOrderStatusErrorState());
      printError(e.toString());
    }
  }

  Future updateAdminComment({
    required int orderId,
    required String comment,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(UpdateOrderStatusLoadingState());
      await DioHelper.postData(url: EndPoints.updateAdminComment, body: {
        'id': orderId,
        'comment': comment,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        DefaultToast.showMyToast(globalResponse!.message.toString());
        printSuccess(
            "Update Order Response ${globalResponse!.message.toString()}");
        emit(UpdateOrderStatusSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(UpdateOrderStatusErrorState());
      printError(n.toString());
    } catch (e) {
      emit(UpdateOrderStatusErrorState());
      printError(e.toString());
    }
  }

  Future createOrder({
    required OrderRequest orderRequest,
    required VoidCallback afterSuccess,
  }) async {
    printError(orderRequest.extraIds.length.toString());
    try {
      emit(CreateOrdersLoadingState());
      await DioHelper.postData(
        url: EndPoints.createOrder,
        body: {
          'userId': orderRequest.userId,
          'packageId':
              orderRequest.packageId == 0 ? null : orderRequest.packageId,
          'calendarId': orderRequest.calendarId,
          'spaceId': null,
          'periodId': orderRequest.periodId,
          'total': orderRequest.total,
          'addressId': orderRequest.addressId,
          'date': orderRequest.date,
          'itemId': orderRequest.itemId == 0 ? null : orderRequest.itemId,
          'comment': null,
          'extras': orderRequest.extraIds.isEmpty ? "" : orderRequest.extraIds,
        },
        formData: false,
      ).then((value) {
        printResponse(value.data.toString());
        orderResponse = GlobalResponse.fromJson(value.data);
        printSuccess("Order Response ${orderResponse!.message.toString()}");
        DefaultToast.showMyToast(orderResponse!.message.toString());
        emit(CreateOrdersSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(CreateOrdersErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CreateOrdersErrorState());
      printError(e.toString());
    }
  }
}
