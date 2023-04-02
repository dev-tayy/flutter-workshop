part of 'auth.bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {
  LoginSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class LoginError extends AuthState {
  LoginError({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {
  SignUpSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class SignUpError extends AuthState {
  SignUpError({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}

class UpdateAccountNameLoading extends AuthState {}

class UpdateAccountNameSuccess extends AuthState {
  UpdateAccountNameSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class UpdateAccountNameError extends AuthState {
  UpdateAccountNameError({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}

class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {
  LogoutSuccess({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class LogoutError extends AuthState {
  LogoutError({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}
