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
}
