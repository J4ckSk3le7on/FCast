import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_cubit.freezed.dart';
part 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState.selectLogin());

  void selectLogin() {
    emit(SignInState.login());
  }

  void selectRegister() {
    emit(SignInState.register());
  }
}
