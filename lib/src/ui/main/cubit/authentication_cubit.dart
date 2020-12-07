import 'package:f_cast/src/data/model/database/user.dart';
import 'package:f_cast/src/data/services/impl/user_service.dart';
import 'package:f_cast/src/data/services/interface/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'authentication_cubit.freezed.dart';
part 'authorization_state.dart';

@injectable
class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthService authService;
  final UserService userService;
  User _user;

  AuthenticationCubit(this.authService, this.userService)
      : super(AuthenticationState.loading()) {
    initAuth();
  }

  Future<void> initAuth() async {
    var isSignedIn = await authService.isSignedIn();
    if (isSignedIn) {
      _user = await userService.getUser();
      if (_user == null) {
        emit(AuthenticationState.onboarding());
      } else {
        emit(AuthenticationState.signedIn());
      }
    } else {
      emit(AuthenticationState.signedOut());
    }
  }

  Future<void> _signedIn() async {
    _user = await userService.getUser();
    if (_user == null) {
      emit(AuthenticationState.onboarding());
    } else {
      emit(AuthenticationState.signedIn());
    }
  }

  Future<void> saveNewUser(List<String> podcastIds) async {
    var email = await authService.getEmail();
    _user = User(email, podcastIds);
    await userService.saveUser(_user);
    _signedIn();
  }

  Future<bool> signInWithEmail(String email, String password) async {
    var result = await authService.signInWithEmailAndPassword(email, password);
    if (result) {
      _signedIn();
    }
    return result;
  }

  Future<bool> registerWithEmail(
      String email, String password, String confirmPassword) async {
    var result = await authService.registerUserWithEmailAndPassword(
        email, password, confirmPassword);
    if (result) {
      _signedIn();
    }
    return result;
  }

  Future<void> signInWithGoogle() async {
    var result = await authService.signInWithGoogle();
    if (result) {
      _signedIn();
    }
  }

  Future<void> signInWithApple() async {
    var result = await authService.signInWithApple();
    if (result) {
      _signedIn();
    }
  }

  Future<void> signOut() async {
    await authService.signOut();
    emit(AuthenticationState.signedOut());
  }
}
