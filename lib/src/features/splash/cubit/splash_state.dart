part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

class ConnectionLoading extends SplashState {}

class ConnectionSuccess extends SplashState {}

class ConnectionFailure extends SplashState {}

class TokenLoading extends SplashState {}

class TokenSuccess extends SplashState {}

class TokenFailure extends SplashState {}
