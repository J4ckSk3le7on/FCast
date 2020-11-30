part of 'sign_in_cubit.dart';

@freezed
abstract class SignInState with _$SignInState {
  factory SignInState.selectLogin() = _SelectLogin;
  factory SignInState.login() = _Login;
  factory SignInState.register() = _Register;
}
