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

class GetMyAddressesLoading extends ClientsState {}
class GetMyAddressesSuccess extends ClientsState {}
class GetMyAddressesFailure extends ClientsState {}

class AddAddressLoading extends ClientsState {}
class AddAddressSuccess extends ClientsState {}
class AddAddressFailure extends ClientsState {}

class GetStatesLoading extends ClientsState {}
class GetStatesSuccess extends ClientsState {}
class GetStatesFailure extends ClientsState {}

class GetAreasLoading extends ClientsState {}
class GetAreasSuccess extends ClientsState {}
class GetAreasFailure extends ClientsState {}
