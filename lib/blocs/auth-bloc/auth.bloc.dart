import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/services/auth.service.dart';

part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await authRepository.login(
          email: event.email,
          password: event.password,
        );
        if (user != null) {
          emit(LoginSuccess(message: "Login success"));
        } else {
          emit(LoginError(error: GENERIC_ERROR));
        }
      } on FirebaseAuthException catch (e) {
        emit(LoginError(error: e.code));
      } catch (e) {
        emit(LoginError(error: GENERIC_ERROR));
      }
    });
    on<SignUpEvent>((event, emit) async {
      emit(SignUpLoading());
      try {
        final user = await authRepository.signUp(
          email: event.email,
          password: event.password,
        );
        if (user != null) {
          emit(SignUpSuccess(message: "You have signed up successfully"));
        } else {
          emit(SignUpError(error: GENERIC_ERROR));
        }
      } on FirebaseAuthException catch (e) {
        emit(SignUpError(error: e.code));
      } catch (e) {
        emit(SignUpError(error: e.toString()));
      }
    });
    on<UpdateAccountNameEvent>((event, emit) async {
      emit(UpdateAccountNameLoading());
      try {
        await authRepository.updateAccountName(name: event.fullName);
        emit(UpdateAccountNameSuccess(
            message: 'You have successfully updated your account name'));
      } on FirebaseAuthException catch (e) {
        emit(UpdateAccountNameError(error: e.code));
      } catch (e) {
        emit(UpdateAccountNameError(error: e.toString()));
      }
    });
    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoading());
      try {
        await authRepository.logout();
        emit(LogoutSuccess(message: 'You have been logged out successfully'));
      } on FirebaseAuthException catch (e) {
        emit(LogoutError(error: e.code));
      } catch (e) {
        emit(LogoutError(error: e.toString()));
      }
    });
  }
  final AuthRepository authRepository;
}
