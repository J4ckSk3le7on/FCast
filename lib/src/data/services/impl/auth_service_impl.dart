import 'package:f_cast/src/data/services/interface/auth_service.dart';
import 'package:f_cast/src/domain/repositories/remote/interface/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthService)
class AuthServiceImpl implements AuthService {
  final AuthRepository authRepository;

  AuthServiceImpl(this.authRepository);

  @override
  Future<bool> signInWithEmailAndPassword(String email, String password) {
    return authRepository.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<bool> registerUserWithEmailAndPassword(
      String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      return false;
    }
    return authRepository.registerWithEmailAndPassword(email, password);
  }

  @override
  Future<bool> isSignedIn() async {
    var user = await authRepository.getUser();
    return user != null;
  }

  @override
  Future<bool> signInWithGoogle() => authRepository.signInWithGoogle();

  @override
  Future<bool> signInWithApple() => authRepository.signInWithApple();

  @override
  Future<void> signOut() => authRepository.signOut();

  @override
  Future<String> getEmail() async {
    var currentUser = await authRepository.getUser();
    return currentUser.email;
  }
}
