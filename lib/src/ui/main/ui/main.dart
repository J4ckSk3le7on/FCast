import 'dart:io';

import 'package:f_cast/src/ui/main/cubit/authentication_cubit.dart';
import 'package:f_cast/src/ui/main/navigation/authentication_information_parser.dart';
import 'package:f_cast/src/ui/main/navigation/authentication_route_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class Main extends StatelessWidget {
  final themeData = ThemeData(
    brightness: Brightness.dark,
  );

  final cupertinoTheme = CupertinoThemeData(
    brightness: Brightness.dark,
  );

  Widget _buildApp(BuildContext context) {
    if (Platform.isIOS) {
      return Theme(
        data: themeData,
        isMaterialAppTheme: true,
        child: CupertinoApp.router(
          theme: cupertinoTheme,
          debugShowCheckedModeBanner: false,
          routeInformationParser: AuthenticationInformationParser(),
          routerDelegate: AuthenticationRouterDelegate(),
        ),
      );
    } else {
      return MaterialApp.router(
        themeMode: ThemeMode.dark,
        theme: themeData,
        debugShowCheckedModeBanner: false,
        routeInformationParser: AuthenticationInformationParser(),
        routerDelegate: AuthenticationRouterDelegate(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.instance.get<AuthenticationCubit>(),
      child: _buildApp(context),
    );
  }
}
