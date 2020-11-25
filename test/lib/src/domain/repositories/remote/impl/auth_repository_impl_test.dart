import 'package:f_cast/src/domain/repositories/remote/impl/auth_repository_impl.dart';
import 'package:f_cast/src/injectible/modules/firebase_auth_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuthModule extends Mock implements FirebaseAuthModule {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  MockFirebaseAuthModule mockFirebaseAuthModule;
  MockFirebaseAuth mockFirebaseAuth;
  FirebaseAuthRepository authRepositoryImpl;
  MockUserCredential userCredential;
  MockUser mockUser;

  setUp(() {
    mockFirebaseAuthModule = MockFirebaseAuthModule();
    mockFirebaseAuth = MockFirebaseAuth();
    when(mockFirebaseAuthModule.firebaseAuth).thenReturn(mockFirebaseAuth);
    authRepositoryImpl = FirebaseAuthRepository(mockFirebaseAuthModule);
    userCredential = MockUserCredential();
    mockUser = MockUser();
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
}
