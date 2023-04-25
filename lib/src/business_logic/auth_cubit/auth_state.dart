part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}


class AuthInitial extends AuthState {}

class ChangePasswordState extends AuthState {}

class LoginLodingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {}


