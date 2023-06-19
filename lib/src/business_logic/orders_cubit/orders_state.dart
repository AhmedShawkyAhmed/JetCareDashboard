part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersSuccessState extends OrdersState {}

class OrdersErrorState extends OrdersState {}

class AssignOrdersLoadingState extends OrdersState {}

class AssignOrdersSuccessState extends OrdersState {}

class AssignOrdersErrorState extends OrdersState {}

class DeleteOrderStatusLoadingState extends OrdersState {}
class DeleteOrderStatusSuccessState extends OrdersState {}
class DeleteOrderStatusErrorState extends OrdersState {}

class UpdateOrderStatusLoadingState extends OrdersState {}
class UpdateOrderStatusSuccessState extends OrdersState {}
class UpdateOrderStatusErrorState extends OrdersState {}

class CreateOrdersLoadingState extends OrdersState {}
class CreateOrdersSuccessState extends OrdersState {}
class CreateOrdersErrorState extends OrdersState {}

class AddCartLoadingState extends OrdersState {}
class AddCartSuccessState extends OrdersState {}
class AddCartErrorState extends OrdersState {}

class ExtraLoadingState extends OrdersState {}
class ExtraSuccessState extends OrdersState {}
class ExtraErrorState extends OrdersState {}

class PeriodLoadingState extends OrdersState {}
class PeriodSuccessState extends OrdersState {}
class PeriodErrorState extends OrdersState {}

class ClientsLoadingState extends OrdersState {}
class ClientsSuccessState extends OrdersState {}
class ClientsErrorState extends OrdersState {}