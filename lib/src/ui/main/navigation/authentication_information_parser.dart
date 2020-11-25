import 'package:f_cast/src/ui/main/cubit/authentication_cubit.dart';
import 'package:flutter/widgets.dart';

class AuthenticationInformationParser
    extends RouteInformationParser<AuthenticationState> {
  @override
  Future<AuthenticationState> parseRouteInformation(
      RouteInformation routeInformation) {
    return Future.value(AuthenticationState.loading());
  }

  @override
  RouteInformation restoreRouteInformation(AuthenticationState path) {
    return RouteInformation(location: "/");
  }
}
