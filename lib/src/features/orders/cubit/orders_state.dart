part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

class GetOrdersLoading extends OrdersState {}
class GetOrdersSuccess extends OrdersState {}
class GetOrdersFailure extends OrdersState {}

class CreateOrderLoading extends OrdersState {}
class CreateOrderSuccess extends OrdersState {}
class CreateOrderFailure extends OrdersState {}

class UpdateOrderStatusLoading extends OrdersState {}
class UpdateOrderStatusSuccess extends OrdersState {}
class UpdateOrderStatusFailure extends OrdersState {}

class UpdateAdminCommentLoading extends OrdersState {}
class UpdateAdminCommentSuccess extends OrdersState {}
class UpdateAdminCommentFailure extends OrdersState {}

class AssignOrderLoading extends OrdersState {}
class AssignOrderSuccess extends OrdersState {}
class AssignOrderFailure extends OrdersState {}

class AddExtraFeesLoading extends OrdersState {}
class AddExtraFeesSuccess extends OrdersState {}
class AddExtraFeesFailure extends OrdersState {}

class AddToCartLoading extends OrdersState {}
class AddToCartSuccess extends OrdersState {}
class AddToCartFailure extends OrdersState {}

class DeleteOrderLoading extends OrdersState {}
class DeleteOrderSuccess extends OrdersState {}
class DeleteOrderFailure extends OrdersState {}
