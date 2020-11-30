import 'package:f_cast/src/data/services/impl/auth_service_impl.dart';
import 'package:f_cast/src/domain/repositories/remote/interface/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUser extends Mock implements User {}

void main() {
  MockAuthRepository mockAuthRepository;
  AuthServiceImpl authServiceImpl;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authServiceImpl = AuthServiceImpl(mockAuthRepository);
  });

  group("sign in with email and password", () {
    test(
        "When sign in with email and password is called, and true is returned from auth repository, true is returned",
        () async {
      //arrange
      var email = "test@test.test";
      var password = "TestPass";
      var returnValue = true;
      when(mockAuthRepository.signInWithEmailAndPassword(email, password))
          .thenAnswer((_) => Future.value(returnValue));

      //act
      var result =
          await authServiceImpl.signInWithEmailAndPassword(email, password);

      //assert
      expect(result, returnValue);
    });
    test(
        "When sign in with email and password is called, and false is returned from auth repository, false is returned",
        () async {
      //arrange
      var email = "test@test.test";
      var password = "TestPass";
      var returnValue = false;
      when(mockAuthRepository.signInWithEmailAndPassword(email, password))
          .thenAnswer((_) => Future.value(returnValue));

      //act
      var result =
          await authServiceImpl.signInWithEmailAndPassword(email, password);

      //assert
      expect(result, returnValue);
    });
  });

  group("register with email and password", () {
    test(
        "When register with email and password returns false, false is returned",
        () async {
      //arrange
      var email = "test@test.test";
      var password = "TestPass";
      var returnValue = false;
      when(mockAuthRepository.registerWithEmailAndPassword(email, password))
          .thenAnswer((_) => Future.value(returnValue));

      //act
      var result = await authServiceImpl.registerUserWithEmailAndPassword(
          email, password, password);

      //assert
      expect(result, returnValue);
    });

    test("When register with email and password returns true, true is returned",
        () async {
      //arrange
      var email = "test@test.test";
      var password = "TestPass";
      var returnValue = true;
      when(mockAuthRepository.registerWithEmailAndPassword(email, password))
          .thenAnswer((_) => Future.value(returnValue));

      //act
      var result = await authServiceImpl.registerUserWithEmailAndPassword(
          email, password, password);

      //assert
      expect(result, returnValue);
    });

    test("When password and confirm password don't match, false is returned",
        () async {
      //arrange
      var email = "test@test.test";
      var password = "TestPass";
      var confirmPassword = "TestPass1";

      //act
      var result = await authServiceImpl.registerUserWithEmailAndPassword(
          email, password, confirmPassword);

      //assert
      expect(result, false);
    });
  });

  group("is user signed in", () {
    test("When user is null, false is returned", () async {
      //arrange
      when(mockAuthRepository.getUser()).thenAnswer((_) => Future.value(null));

      //act
      var result = await authServiceImpl.isSignedIn();

      //assert
      expect(result, false);
    });

    test("when user is found, true is returned", () async {
      //arrange
      when(mockAuthRepository.getUser())
          .thenAnswer((_) => Future.value(MockUser()));

      //act
      var result = await authServiceImpl.isSignedIn();

      //assert
      expect(result, true);
    });
  });

  group("Sign in with apple", () {
    test("When sign in with apple returns true, true is returned", () async {
      //arrange
      when(mockAuthRepository.signInWithApple())
          .thenAnswer((realInvocation) => Future.value(true));

      //act
      var result = await authServiceImpl.signInWithApple();

      //assert
      expect(result, true);
      verify(mockAuthRepository.signInWithApple()).called(1);
    });

    test("When sign in with apple returns false, false is returned", () async {
      //arrange
      when(mockAuthRepository.signInWithApple())
          .thenAnswer((realInvocation) => Future.value(false));

      //act
      var result = await authServiceImpl.signInWithApple();

      //assert
      expect(result, false);
      verify(mockAuthRepository.signInWithApple()).called(1);
    });
  });

  group("Sign in with google", () {
    test("when sign in with google returns true, true is returned", () async {
      //arrange
      when(mockAuthRepository.signInWithGoogle())
          .thenAnswer((realInvocation) => Future.value(true));

      //act
      var result = await authServiceImpl.signInWithGoogle();

      //assert
      expect(result, true);
      verify(mockAuthRepository.signInWithGoogle()).called(1);
    });

    test("when sign in with google returns false, false is returned", () async {
      //arrange
      when(mockAuthRepository.signInWithGoogle())
          .thenAnswer((realInvocation) => Future.value(false));

      //act
      var result = await authServiceImpl.signInWithGoogle();

      //assert
      expect(result, false);
      verify(mockAuthRepository.signInWithGoogle()).called(1);
    });
  });

  group("Sign out", () {
    test("When sign out is called, it's passed to the repo", () async {
      //arrange

      //act
      await mockAuthRepository.signOut();

      //assert
      verify(mockAuthRepository.signOut()).called(1);
    });
  });
}
