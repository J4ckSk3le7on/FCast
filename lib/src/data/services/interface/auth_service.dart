abstract class AuthService {
  Future<bool> signInWithEmailAndPassword(String email, String password);
  Future<bool> registerUserWithEmailAndPassword(
      String email, String password, String confirmPassword);
  Future<bool> signInWithGoogle();
  Future<bool> signInWithApple();
  Future<bool> isSignedIn();
  Future<void> signOut();
}
