part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}


class AuthInitial extends AuthState {}

class ChangePasswordState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}


class FCMLoadingState extends AuthState {}
class FCMSuccessState extends AuthState {}
class FCMErrorState extends AuthState {}


