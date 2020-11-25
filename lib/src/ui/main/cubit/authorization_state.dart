part of 'authentication_cubit.dart';

@freezed
abstract class AuthenticationState with _$AuthenticationState {
  factory AuthenticationState.loading() = Loading;
  factory AuthenticationState.signedOut() = SignedOut;
  factory AuthenticationState.signedIn() = SignedIn;
}
