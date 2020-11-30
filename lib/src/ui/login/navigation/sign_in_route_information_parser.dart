import 'package:f_cast/src/ui/login/cubit/sign_in_cubit.dart';
import 'package:flutter/cupertino.dart';

class SignInRouteInformationParser extends RouteInformationParser<SignInState> {
  @override
  Future<SignInState> parseRouteInformation(RouteInformation routeInformation) {
    return Future.value(SignInState.selectLogin());
  }
}
