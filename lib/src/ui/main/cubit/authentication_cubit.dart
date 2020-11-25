import 'package:f_cast/src/data/services/interface/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'authentication_cubit.freezed.dart';
part 'authorization_state.dart';

@injectable
class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthService authService;

  AuthenticationCubit(this.authService) : super(AuthenticationState.loading()) {
    initAuth();
  }

  Future<void> initAuth() async {
    var isSignedIn = await authService.isSignedIn();
    if (isSignedIn) {
      emit(AuthenticationState.signedIn());
    } else {
      emit(AuthenticationState.signedOut());
    }
  }

  Future<void> signedIn() async {
    emit(AuthenticationState.signedIn());
  }
}
