part of 'auth.bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  LoginEvent({required this.email, required this.password});
  final String email, password;
  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  SignUpEvent({
    required this.email,
    required this.password,
  });
  final String password, email;
  @override
  List<Object> get props => [password, email];
}

class UpdateAccountNameEvent extends AuthEvent {
  UpdateAccountNameEvent({required this.fullName});
  final String fullName;
  @override
  List<Object> get props => [fullName];
}

class LogoutEvent extends AuthEvent {}
