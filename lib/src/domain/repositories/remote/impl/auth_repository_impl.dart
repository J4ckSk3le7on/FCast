import 'package:f_cast/src/domain/repositories/remote/interface/auth_repository.dart';
import 'package:f_cast/src/domain/repositories/remote/module/sign_in_apple_module.dart';
import 'package:f_cast/src/injectible/modules/firebase_auth_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

@Injectable(as: AuthRepository)
class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthModule firebaseAuth;
  final GoogleSignIn googleSignIn;
  final SignInAppleModule signInAppleModule;

  FirebaseAuthRepository(
      this.firebaseAuth, this.googleSignIn, this.signInAppleModule);

  @override
  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await firebaseAuth.firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return result.user != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      var result = await firebaseAuth.firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return result.user != null;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<User> getUser() async {
    return firebaseAuth.firebaseAuth.currentUser;
  }

  @override
  Future<bool> signInWithGoogle() async {
    var account = await googleSignIn.signIn();
    var auth = await account.authentication;
    if (auth == null) {
      return false;
    }

    var credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);

    var authResult =
        await firebaseAuth.firebaseAuth.signInWithCredential(credential);
    var user = authResult.user;
    if (user == null) {
      return false;
    }
    user.updateEmail(account.email);
    return true;
  }

  Future<bool> signInWithApple() async {
    try {
      var result = await signInAppleModule.getSignInWithAppleResult();

      if (result != null) {
        var oAuthProvider = OAuthProvider("apple.com");
        var credential = oAuthProvider.credential(
            idToken: result.identityToken,
            accessToken: result.authorizationCode);
        var authResult =
            await firebaseAuth.firebaseAuth.signInWithCredential(credential);
        var user = authResult.user;
        return user != null;
      }
      return false;
    } on SignInWithAppleAuthorizationException catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> signOut() async => firebaseAuth.firebaseAuth.signOut();
}
