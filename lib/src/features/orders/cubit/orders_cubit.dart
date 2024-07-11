import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:jetboard/src/core/di/service_locator.dart';
import 'package:jetboard/src/core/network/models/network_base_model.dart';
import 'package:jetboard/src/core/network/models/network_exceptions.dart';
import 'package:jetboard/src/core/services/navigation_service.dart';
import 'package:jetboard/src/core/utils/enums.dart';
import 'package:jetboard/src/features/notifications/cubit/notifications_cubit.dart';
import 'package:jetboard/src/features/notifications/data/requests/notification_request.dart';
import 'package:jetboard/src/features/orders/data/models/order_model.dart';
import 'package:jetboard/src/features/orders/data/repo/orders_repo.dart';
import 'package:jetboard/src/features/orders/data/requests/cart_request.dart';
import 'package:jetboard/src/features/orders/data/requests/order_request.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.repo) : super(OrdersInitial());
  final OrdersRepo repo;

  List<OrderModel>? orders;
  NotificationsCubit notificationCubit = NotificationsCubit(instance());

  Future getOrders({
    String? keyword,
    String? status,
  }) async {
    emit(GetOrdersLoading());
    var response = await repo.getOrders(
      keyword: keyword,
      status: status,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        orders = response.data;
        emit(GetOrdersSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(GetOrdersFailure());
        error.showError();
      },
    );
  }

  Future createOrder({
    required OrderRequest request,
  }) async {
    emit(CreateOrderLoading());
    var response = await repo.createOrder(request: request);
    response.when(
      success: (NetworkBaseModel response) async {
        getOrders();
        emit(CreateOrderSuccess());
        NavigationService.pop();
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(CreateOrderFailure());
        error.showError();
      },
    );
  }

  Future updateOrderStatus({
    required int id,
    required OrderStatus status,
    String? reason,
  }) async {
    emit(UpdateOrderStatusLoading());
    var response = await repo.updateOrderStatus(
      id: id,
      status: status,
      reason: reason,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        OrderModel order = orders!.firstWhere((item) => item.id == id);
        if (status == OrderStatus.canceled ||
            status == OrderStatus.unassigned) {
          order.crew = null;
        }
        order.status = status;
        emit(UpdateOrderStatusSuccess());
        notificationCubit.notifyUser(
          request: NotificationRequest(
            userId: order.user!.id!,
            title: "الطلبات",
            message:
                "تم تغيير حالة طلبك رقم ${order.id} إلي ${status.name.toUpperCase()}",
          ),
        );
      },
      failure: (NetworkExceptions error) {
        emit(UpdateOrderStatusFailure());
        error.showError();
      },
    );
  }

  Future updateAdminComment({
    required int orderId,
    required String adminComment,
    required VoidCallback afterSuccess,
  }) async {
    emit(UpdateAdminCommentLoading());
    var response = await repo.updateAdminComment(
      orderId: orderId,
      adminComment: adminComment,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(UpdateAdminCommentSuccess());
        afterSuccess();
      },
      failure: (NetworkExceptions error) {
        emit(UpdateAdminCommentFailure());
        error.showError();
      },
    );
  }

  Future assignOrder({
    required int orderId,
    required int crewId,
    required String date,
  }) async {
    emit(AssignOrderLoading());
    var response = await repo.assignOrder(
      orderId: orderId,
      crewId: crewId,
      date: date,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(AssignOrderSuccess());
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AssignOrderFailure());
        error.showError();
      },
    );
  }

  Future addExtraFees({
    required int orderId,
    required double extraFees,
  }) async {
    emit(AddExtraFeesLoading());
    var response = await repo.addExtraFees(
      orderId: orderId,
      extraFees: extraFees,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        OrderModel order = orders!.firstWhere((item) => item.id == orderId);
        order.extra = extraFees;
        order.total = order.price! + order.shipping! + order.extra!;
        emit(AddExtraFeesSuccess());
        NavigationService.pop();
      },
      failure: (NetworkExceptions error) {
        emit(AddExtraFeesFailure());
        error.showError();
      },
    );
  }

  Future addToCart({
    required CartRequest request,
  }) async {
    emit(AddToCartLoading());
    var response = await repo.addToCart(
      request: request,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        emit(AddToCartSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(AddToCartFailure());
        error.showError();
      },
    );
  }

  Future deleteOrder({
    required int id,
  }) async {
    emit(DeleteOrderLoading());
    var response = await repo.deleteOrder(
      id: id,
    );
    response.when(
      success: (NetworkBaseModel response) async {
        if (orders != null) {
          orders!.removeWhere((item) => item.id == id);
        }
        emit(DeleteOrderSuccess());
      },
      failure: (NetworkExceptions error) {
        emit(DeleteOrderFailure());
        error.showError();
      },
    );
  }
}
