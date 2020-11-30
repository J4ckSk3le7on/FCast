import 'package:f_cast/src/domain/repositories/remote/impl/auth_repository_impl.dart';
import 'package:f_cast/src/domain/repositories/remote/module/sign_in_apple_module.dart';
import 'package:f_cast/src/injectible/modules/firebase_auth_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class MockFirebaseAuthModule extends Mock implements FirebaseAuthModule {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSingInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockAuthCredential extends Mock implements UserCredential {}

class MockAppleModule extends Mock implements SignInAppleModule {}

// ignore: must_be_immutable
class MockAuthorizationCredentialAppleID extends Mock
    implements AuthorizationCredentialAppleID {}

void main() {
  MockFirebaseAuthModule mockFirebaseAuthModule;
  MockFirebaseAuth mockFirebaseAuth;
  FirebaseAuthRepository authRepositoryImpl;
  MockUserCredential userCredential;
  MockGoogleSignIn mockGoogleSignIn;
  MockGoogleSignInAccount mockGoogleSignInAccount;
  MockGoogleSingInAuthentication mockGoogleSingInAuthentication;
  MockAuthCredential mockAuthCredential;
  MockAppleModule mockAppleModule;
  MockAuthorizationCredentialAppleID mockAuthorizationCredentialAppleID;
  MockUser mockUser;

  setUp(() {
    mockFirebaseAuthModule = MockFirebaseAuthModule();
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockAppleModule = MockAppleModule();
    authRepositoryImpl = FirebaseAuthRepository(
        mockFirebaseAuthModule, mockGoogleSignIn, mockAppleModule);
    userCredential = MockUserCredential();
    mockUser = MockUser();
    mockGoogleSingInAuthentication = MockGoogleSingInAuthentication();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockAuthCredential = MockAuthCredential();
    mockAuthorizationCredentialAppleID = MockAuthorizationCredentialAppleID();
    when(mockFirebaseAuthModule.firebaseAuth).thenReturn(mockFirebaseAuth);
  });

  group("sign in with email and password", () {
    test("When user is returned from firebase, true is returned", () async {
      //arrange
      var email = "test@test.test";
      var password = "TestPass";
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .thenAnswer((_) => Future.value(userCredential));
      when(userCredential.user).thenReturn(mockUser);

      //act
      var result =
          await authRepositoryImpl.signInWithEmailAndPassword(email, password);

      //assert
      expect(result, true);
    });
    test("When null is returned from firebase, false is returned", () async {
      //arrange
      var email = "test@test.test";
      var password = "TestPass";
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .thenAnswer((_) => Future.value(userCredential));
      when(userCredential.user).thenReturn(null);

      //act
      var result =
          await authRepositoryImpl.signInWithEmailAndPassword(email, password);

      //assert
      expect(result, false);
    });
  });

  group("register with email and password", () {
    test("When user is returned from firebase, true is returned", () async {
      //arrange
      var email = "test@test.test";
      var password = "TestPass";
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .thenAnswer((_) => Future.value(userCredential));
      when(userCredential.user).thenReturn(mockUser);

      //act
      var result = await authRepositoryImpl.registerWithEmailAndPassword(
          email, password);

      //assert
      expect(result, true);
    });
    test("When null is returned from firebase, false is returned", () async {
      //arrange
      var email = "test@test.test";
      var password = "TestPass";
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .thenAnswer((_) => Future.value(userCredential));
      when(userCredential.user).thenReturn(null);

      //act
      var result = await authRepositoryImpl.registerWithEmailAndPassword(
          email, password);

      //assert
      expect(result, false);
    });
  });

  group("Sign out", () {
    test("When sign out is called, it's passed to firebase", () async {
      //arrange

      //act
      await authRepositoryImpl.signOut();

      //verify
      verify(mockFirebaseAuth.signOut()).called(1);
    });
  });

  group("Sign in with google", () {
    test("When authentication returns null, false is returned", () async {
      //arrange
      when(mockGoogleSignIn.signIn()).thenAnswer(
          (realInvocation) => Future.value(mockGoogleSignInAccount));
      when(mockGoogleSignInAccount.authentication)
          .thenAnswer((realInvocation) => Future.value(null));

      //act
      var result = await authRepositoryImpl.signInWithGoogle();

      //assert
      expect(result, false);
    });

    test("When signInWithCredential returns null user, false is returned",
        () async {
      //arrange
      when(mockGoogleSignIn.signIn()).thenAnswer(
          (realInvocation) => Future.value(mockGoogleSignInAccount));
      when(mockGoogleSignInAccount.authentication).thenAnswer(
          (realInvocation) => Future.value(mockGoogleSingInAuthentication));
      when(mockGoogleSingInAuthentication.idToken).thenReturn("test");
      when(mockGoogleSingInAuthentication.accessToken).thenReturn("test");
      when(mockFirebaseAuth.signInWithCredential(any))
          .thenAnswer((realInvocation) => Future.value(mockAuthCredential));
      when(mockAuthCredential.user).thenReturn(null);

      //act
      var result = await authRepositoryImpl.signInWithGoogle();

      //assert
      expect(result, false);
    });

    test("When signInWithCredential returns a user, true is returned",
        () async {
      //arrange
      when(mockGoogleSignIn.signIn()).thenAnswer(
          (realInvocation) => Future.value(mockGoogleSignInAccount));
      when(mockGoogleSignInAccount.authentication).thenAnswer(
          (realInvocation) => Future.value(mockGoogleSingInAuthentication));
      when(mockGoogleSingInAuthentication.idToken).thenReturn("test");
      when(mockGoogleSingInAuthentication.accessToken).thenReturn("test");
      when(mockFirebaseAuth.signInWithCredential(any))
          .thenAnswer((realInvocation) => Future.value(mockAuthCredential));
      when(mockAuthCredential.user).thenReturn(mockUser);
      when(mockUser.email).thenReturn("test");

      //act
      var result = await authRepositoryImpl.signInWithGoogle();

      //assert
      expect(result, true);
    });
  });

  group("Sign in with apple", () {
    test("when sign in with apple returns a null result, false is returned",
        () async {
      //arrange
      when(mockAppleModule.getSignInWithAppleResult())
          .thenAnswer((_) => Future.value(null));

      //act
      var result = await authRepositoryImpl.signInWithApple();

      //assert
      expect(result, false);
    });

    test(
        "when sign in with apple credential returns a null user, false is returned",
        () async {
      //arrange
      when(mockAppleModule.getSignInWithAppleResult())
          .thenAnswer((_) => Future.value(mockAuthorizationCredentialAppleID));
      when(mockAuthorizationCredentialAppleID.identityToken).thenReturn("test");
      when(mockAuthorizationCredentialAppleID.authorizationCode)
          .thenReturn("test");
      when(mockFirebaseAuth.signInWithCredential(any))
          .thenAnswer((_) => Future.value(mockAuthCredential));
      when(mockAuthCredential.user).thenReturn(null);

      //act
      var result = await authRepositoryImpl.signInWithApple();

      //assert
      expect(result, false);
    });

    test("when sign in with apple credential returns a user, true is returned",
        () async {
      //arrange
      when(mockAppleModule.getSignInWithAppleResult())
          .thenAnswer((_) => Future.value(mockAuthorizationCredentialAppleID));
      when(mockAuthorizationCredentialAppleID.identityToken).thenReturn("test");
      when(mockAuthorizationCredentialAppleID.authorizationCode)
          .thenReturn("test");
      when(mockFirebaseAuth.signInWithCredential(any))
          .thenAnswer((_) => Future.value(mockAuthCredential));
      when(mockAuthCredential.user).thenReturn(mockUser);

      //act
      var result = await authRepositoryImpl.signInWithApple();

      //assert
      expect(result, true);
    });

    test(
        "when SignInWithAppleAuthorizationException is thrown, false is returned",
        () async {
      //arrange
      when(mockAppleModule.getSignInWithAppleResult()).thenThrow(
          SignInWithAppleAuthorizationException(
              code: AuthorizationErrorCode.failed, message: "test"));

      //act
      var result = await authRepositoryImpl.signInWithApple();

      //assert
      expect(result, false);
    });
  });
}
