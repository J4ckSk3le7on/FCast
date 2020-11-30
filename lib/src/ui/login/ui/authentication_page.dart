import 'package:f_cast/src/ui/common/ui/platform_page.dart';
import 'package:f_cast/src/ui/login/cubit/sign_in_cubit.dart';
import 'package:f_cast/src/ui/login/navigation/sign_in_route_delegate.dart';
import 'package:f_cast/src/ui/login/navigation/sign_in_route_information_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AuthenticationPage extends PlatformPage {
  AuthenticationPage() : super(AuthenticationWidget(), "/auth");
}

class AuthenticationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance.get<SignInCubit>(),
      child: Router(
        routerDelegate: SignInRouteDelegate(),
        routeInformationParser: SignInRouteInformationParser(),
      ),
    );
  }
}
