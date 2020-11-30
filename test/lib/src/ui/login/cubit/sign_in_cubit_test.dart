import 'package:bloc_test/bloc_test.dart';
import 'package:f_cast/src/ui/login/cubit/sign_in_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  SignInCubit signInCubit;

  setUp(() {
    signInCubit = SignInCubit();
  });

  group("Select login", () {
    blocTest(
      "When select login is called, [Login] is emitted",
      build: () => signInCubit,
      act: (SignInCubit cubit) => cubit.selectLogin(),
      expect: [SignInState.login()],
    );
  });

  group("Select register", () {
    blocTest(
      "When select login is called, [register] is emitted",
      build: () => signInCubit,
      act: (SignInCubit cubit) => cubit.selectRegister(),
      expect: [SignInState.register()],
    );
  });
}
