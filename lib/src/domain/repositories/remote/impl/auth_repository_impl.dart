import 'package:f_cast/src/domain/repositories/remote/interface/auth_repository.dart';
import 'package:f_cast/src/injectible/modules/firebase_auth_module.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuthModule firebaseAuth;

  FirebaseAuthRepository(this.firebaseAuth);

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
}
