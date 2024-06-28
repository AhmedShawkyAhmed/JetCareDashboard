part of 'clients_cubit.dart';

@immutable
sealed class ClientsState {}

final class ClientsInitial extends ClientsState {}

class PickedSwitchState extends ClientsState {}

class GetClientsLoading extends ClientsState {}
class GetClientsSuccess extends ClientsState {}
class GetClientsFailure extends ClientsState {}

class AddClientLoading extends ClientsState {}
class AddClientSuccess extends ClientsState {}
class AddClientFailure extends ClientsState {}

class UpdateClientLoading extends ClientsState {}
class UpdateClientSuccess extends ClientsState {}
class UpdateClientFailure extends ClientsState {}

class ActivateAccountLoading extends ClientsState {}
class ActivateAccountSuccess extends ClientsState {}
class ActivateAccountFailure extends ClientsState {}

class StopAccountLoading extends ClientsState {}
class StopAccountSuccess extends ClientsState {}
class StopAccountFailure extends ClientsState {}

class DeleteClientLoading extends ClientsState {}
class DeleteClientSuccess extends ClientsState {}
class DeleteClientFailure extends ClientsState {}

class UserAdminCommentLoading extends ClientsState {}
class UserAdminCommentSuccess extends ClientsState {}
class UserAdminCommentFailure extends ClientsState {}
