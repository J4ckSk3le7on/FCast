import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<bool> signInWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword(String email, String password);
  Future<bool> signInWithGoogle();
  Future<bool> signInWithApple();
  Future<User> getUser();
  Future<void> signOut();
}
