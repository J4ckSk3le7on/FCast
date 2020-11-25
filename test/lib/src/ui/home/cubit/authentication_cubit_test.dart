import 'package:bloc_test/bloc_test.dart';
import 'package:f_cast/src/data/services/interface/auth_service.dart';
import 'package:f_cast/src/ui/main/cubit/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationService extends Mock implements AuthService {}

void main() {
  MockAuthenticationService mockAuthenticationService;
  AuthenticationCubit authenticationCubit;

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
    authenticationCubit = AuthenticationCubit(mockAuthenticationService);
  });

  group("Init auth", () {
    blocTest(
        "When init auth is emitted, and user is not signed in, [SignedOut] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((_) => Future.value(false));
      return authenticationCubit;
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.initAuth();
    }, expect: [AuthenticationState.signedOut()]);

    blocTest(
        "When init auth is emitted, and user is signed in, [SignedIn] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((_) => Future.value(true));
      return authenticationCubit;
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.initAuth();
    }, expect: [AuthenticationState.signedIn()]);
  });

  group("Sign In", () {
    blocTest("when SignedIn is called, [SignedIn is emitted]", build: () {
      return authenticationCubit;
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.signedIn();
    }, expect: [AuthenticationState.signedIn()]);
  });
}
