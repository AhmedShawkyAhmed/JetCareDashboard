import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jetboard/src/data/models/orders_model.dart';
import 'package:jetboard/src/data/network/requests/order_request.dart';
import 'package:jetboard/src/data/network/responses/global_response.dart';
import 'package:jetboard/src/data/network/responses/period_response.dart';
import 'package:jetboard/src/data/network/responses/user_response.dart';
import 'package:jetboard/src/presentation/widgets/toast.dart';
import 'package:jetboard/src/core/utils/shared_methods.dart';
import 'package:jetboard/src/core/network/end_points.dart';
import 'package:jetboard/src/core/network/network_service.dart';
import '../../data/network/responses/orders_response.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.networkService) : super(OrdersInitial());
  NetworkService networkService;
  static OrdersCubit get(context) => BlocProvider.of(context);
  OrdersResponse? getOrdersResponse, updateOrdersStatusResponse;
  UserResponse? clientsResponse;
  GlobalResponse? globalResponse, orderResponse;
  PeriodResponse? periodResponse;
  List<String> periods = [];
  List<String> clients = [];
  List<OrdersModel> ordersList = [];
  int listCount = 0;
  int index = 0;
  List<int> cartId = [];

  Future addToCart({
    required int userId,
    required int count,
    required double price,
    required VoidCallback afterSuccess,
    int? packageId,
    int? itemId,
  }) async {
    try {
      emit(AddCartLoadingState());
      await networkService.post(
        url: EndPoints.addToCart,
        body: {
          'userId': userId,
          'count': count,
          'price': price,
          'packageId': packageId,
          'itemId': itemId,
        },
      ).then((value) {
        emit(AddCartSuccessState());
        cartId.add(value.data['cartId']);
        printLog(value.data['cartId'].toString());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(AddCartErrorState());
      printError(n.toString());
    } catch (e) {
      emit(AddCartErrorState());
      printError(e.toString());
    }
  }

  Future getOrders({
    String? keyword,
    type,
  }) async {
    ordersList.clear();
    listCount = 0;
    getOrdersResponse = null;
    try {
      emit(OrdersLoadingState());
      await networkService.get(
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
    required String date,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(AssignOrdersLoadingState());
      await networkService.post(
        url: EndPoints.assignOrder,
        body: {
          'id': id,
          'crewId': crewId,
          'date': date,
        },
      ).then((value) {
        updateOrdersStatusResponse = OrdersResponse.fromJson(value.data);
        if(value.data['status'] == 200){
          getOrders();
          afterSuccess();
        }
        if(value.data['status'] == 502){
          DefaultToast.showMyToast(value.data['message'].toString(),toastLength: Toast.LENGTH_LONG);
        }
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
      await networkService.post(url: EndPoints.deleteOrder, body: {
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

  Future updateExtras({
    required int orderId,
    required double extra,
    required VoidCallback afterSuccess,
  }) async {
    try {
      emit(ExtraLoadingState());
      await networkService.post(url: EndPoints.updateExtra, body: {
        'id': orderId,
        'extra': extra,
      }).then((value) {
        globalResponse = GlobalResponse.fromJson(value.data);
        DefaultToast.showMyToast(globalResponse!.message.toString());
        emit(ExtraSuccessState());
        afterSuccess();
      });
    } on DioError catch (n) {
      emit(ExtraErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ExtraErrorState());
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
      await networkService.post(url: EndPoints.updateOrderStatus, body: {
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
      await networkService.post(url: EndPoints.updateAdminComment, body: {
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
    try {
      printLog(cartId.length.toString());
      emit(CreateOrdersLoadingState());
      await networkService.post(
        url: EndPoints.createOrder,
        body: {
          'userId': orderRequest.userId,
          'periodId': orderRequest.periodId,
          'addressId': orderRequest.addressId,
          'date': orderRequest.date,
          'price': orderRequest.price,
          'shipping': orderRequest.shipping,
          'total': orderRequest.total,
          'comment': orderRequest.comment,
          'cart': cartId.isEmpty ? "" : cartId,
        },
      ).then((value) {
        printResponse(value.data.toString());
        orderResponse = GlobalResponse.fromJson(value.data);
        printSuccess("Order Response ${orderResponse!.message.toString()}");
        DefaultToast.showMyToast(orderResponse!.message.toString());
        emit(CreateOrdersSuccessState());
        afterSuccess();
        cartId.clear();
      });
    } on DioError catch (n) {
      emit(CreateOrdersErrorState());
      printError(n.toString());
    } catch (e) {
      emit(CreateOrdersErrorState());
      printError(e.toString());
    }
  }

  Future getPeriodsMobile() async {
    try {
      emit(PeriodLoadingState());
      await networkService.get(
        url: EndPoints.getPeriodsMobile,
      ).then((value) {
        periodResponse = PeriodResponse.fromJson(value.data);
        emit(PeriodLoadingState());
        for(int i = 0; i < periodResponse!.periodModel!.length;i++){
          periods.add("${periodResponse!.periodModel![i].from} - ${periodResponse!.periodModel![i].to}");
        }
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(PeriodLoadingState());
      printError(n.toString());
    } catch (e) {
      emit(PeriodLoadingState());
      printError(e.toString());
    }
  }

  Future getClients() async {
    try {
      emit(ClientsLoadingState());
      await networkService.get(
        url: EndPoints.getAccounts,
        query: {
          "type": "client",
        },
      ).then((value) {
        clientsResponse = UserResponse.fromJson(value.data);
        for(int i = 0; i < clientsResponse!.userModel!.length;i++){
          clients.add("${clientsResponse!.userModel![i].name} - ${clientsResponse!.userModel![i].phone}");
        }
        emit(ClientsSuccessState());
        printSuccess(value.data.toString());
      });
    } on DioError catch (n) {
      emit(ClientsErrorState());
      printError(n.toString());
    } catch (e) {
      emit(ClientsErrorState());
      printError(e.toString());
    }
  }
}
