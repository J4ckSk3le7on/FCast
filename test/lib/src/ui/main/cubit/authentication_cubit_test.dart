import 'package:bloc_test/bloc_test.dart';
import 'package:f_cast/src/data/services/interface/auth_service.dart';
import 'package:f_cast/src/ui/main/cubit/authentication_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthenticationService extends Mock implements AuthService {}

void main() {
  MockAuthenticationService mockAuthenticationService;

  setUp(() {
    mockAuthenticationService = MockAuthenticationService();
  });

  group("Init auth", () {
    blocTest(
        "When init auth is emitted, and user is not signed in, [SignedOut] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((_) => Future.value(false));
      return AuthenticationCubit(mockAuthenticationService);
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.initAuth();
    }, expect: [AuthenticationState.signedOut()]);

    blocTest(
        "When init auth is emitted, and user is signed in, [SignedIn] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((_) => Future.value(true));
      return AuthenticationCubit(mockAuthenticationService);
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.initAuth();
    }, expect: [AuthenticationState.signedIn()]);
  });

  group("Sign in with email", () {
    blocTest("when SignedIn is successful, [SignedOut, SignedIn] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockAuthenticationService.signInWithEmailAndPassword(any, any))
          .thenAnswer((realInvocation) => Future.value(true));
      return AuthenticationCubit(mockAuthenticationService);
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.signInWithEmail("test", "test");
    }, expect: [
      AuthenticationState.signedOut(),
      AuthenticationState.signedIn()
    ]);

    blocTest("when SignedIn is unsuccessful, [SignedOut] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockAuthenticationService.signInWithEmailAndPassword(any, any))
          .thenAnswer((realInvocation) => Future.value(false));
      return AuthenticationCubit(mockAuthenticationService);
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.signInWithEmail("test", "test");
    }, expect: [AuthenticationState.signedOut()]);
  });

  group("register in with email", () {
    blocTest("when SignedIn is successful, [SignedOut, SignedIn] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockAuthenticationService.registerUserWithEmailAndPassword(
              any, any, any))
          .thenAnswer((realInvocation) => Future.value(true));
      return AuthenticationCubit(mockAuthenticationService);
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.registerWithEmail("test", "test", "test");
    }, expect: [
      AuthenticationState.signedOut(),
      AuthenticationState.signedIn()
    ]);

    blocTest("when SignedIn is unsuccessful, [SignedOut] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockAuthenticationService.registerUserWithEmailAndPassword(
              any, any, any))
          .thenAnswer((realInvocation) => Future.value(false));
      return AuthenticationCubit(mockAuthenticationService);
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.registerWithEmail("test", "test", "test");
    }, expect: [AuthenticationState.signedOut()]);
  });

  group("Sign in google", () {
    blocTest("when SignedIn is successful, [SignedOut, SignedIn] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockAuthenticationService.signInWithGoogle())
          .thenAnswer((realInvocation) => Future.value(true));
      return AuthenticationCubit(mockAuthenticationService);
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.signInWithGoogle();
    }, expect: [
      AuthenticationState.signedOut(),
      AuthenticationState.signedIn()
    ]);

    blocTest("when SignedIn is unsuccessful, [SignedOut] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockAuthenticationService.signInWithGoogle())
          .thenAnswer((realInvocation) => Future.value(false));
      return AuthenticationCubit(mockAuthenticationService);
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.signInWithGoogle();
    }, expect: [AuthenticationState.signedOut()]);
  });

  group("Sign in apple", () {
    blocTest("when SignedIn is successful, [SignedOut, SignedIn] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockAuthenticationService.signInWithApple())
          .thenAnswer((realInvocation) => Future.value(true));
      return AuthenticationCubit(mockAuthenticationService);
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.signInWithApple();
    }, expect: [
      AuthenticationState.signedOut(),
      AuthenticationState.signedIn()
    ]);

    blocTest("when SignedIn is unsuccessful, [SignedOut] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((realInvocation) => Future.value(false));
      when(mockAuthenticationService.signInWithApple())
          .thenAnswer((realInvocation) => Future.value(false));
      return AuthenticationCubit(mockAuthenticationService);
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.signInWithApple();
    }, expect: [AuthenticationState.signedOut()]);
  });

  group("Sign out", () {
    blocTest("when signOut is called, [SignedIn, SignedOut] is emitted",
        build: () {
      when(mockAuthenticationService.isSignedIn())
          .thenAnswer((realInvocation) => Future.value(true));
      return AuthenticationCubit(mockAuthenticationService);
    }, act: (AuthenticationCubit authenticationCubit) {
      authenticationCubit.signOut();
    }, expect: [
      AuthenticationState.signedIn(),
      AuthenticationState.signedOut(),
    ]);
  });
}
