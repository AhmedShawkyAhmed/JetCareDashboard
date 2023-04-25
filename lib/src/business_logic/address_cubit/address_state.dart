part of 'address_cubit.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoadingState extends AddressState {}
class AddressSuccessState extends AddressState {}
class AddressErrorState extends AddressState {}

class AddAddressLoadingState extends AddressState {}
class AddAddressSuccessState extends AddressState {}
class AddAddressErrorState extends AddressState {}

class DeleteAddressLoadingState extends AddressState {}
class DeleteAddressSuccessState extends AddressState {}
class DeleteAddressErrorState extends AddressState {}

class EditAddressLoadingState extends AddressState {}
class EditAddressSuccessState extends AddressState {}
class EditAddressErrorState extends AddressState {}