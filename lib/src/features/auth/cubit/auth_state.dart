part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthenticateInitial extends AuthState {}

class LoginLoading extends AuthState {}
class LoginSuccess extends AuthState {}
class LoginFailure extends AuthState {}

class FCMLoading extends AuthState {}
class FCMSuccess extends AuthState {}
class FCMFailure extends AuthState {}

class ProfileLoading extends AuthState {}
class ProfileSuccess extends AuthState {}
class ProfileFailure extends AuthState {}

class TabAccessLoading extends AuthState {}
class TabAccessSuccess extends AuthState {}
class TabAccessFailure extends AuthState {}

class LogoutLoading extends AuthState {}
class LogoutSuccess extends AuthState {}
class LogoutFailure extends AuthState {}
