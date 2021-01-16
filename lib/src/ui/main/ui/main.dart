import 'dart:io';

import 'package:f_cast/src/ui/main/cubit/authentication_cubit.dart';
import 'package:f_cast/src/ui/main/navigation/authentication_information_parser.dart';
import 'package:f_cast/src/ui/main/navigation/authentication_route_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class Main extends StatelessWidget {
  static final textColor = Colors.white;
  final themeData = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Color(0xff124559),
    scaffoldBackgroundColor: Color(0xff124559),
    canvasColor: Color(0xff124559),
    buttonTheme: ButtonThemeData(
      buttonColor: Color(0xff734B5E),
    ),
    iconTheme: IconThemeData(color: Colors.white),
    cardColor: Color(0xff598392),
    bottomAppBarColor: Color(0xff598392),
    textTheme: GoogleFonts.latoTextTheme(
      TextTheme(
        headline1: TextStyle(color: textColor, fontSize: 42),
        headline2: TextStyle(color: textColor, fontSize: 36),
        headline3: TextStyle(color: textColor, fontSize: 24),
        headline4: TextStyle(color: textColor, fontSize: 21),
        headline5: TextStyle(color: textColor, fontSize: 15),
        bodyText1: TextStyle(color: textColor, fontSize: 24),
        bodyText2: TextStyle(color: textColor, fontSize: 18),
        caption: TextStyle(color: Color(0xff8585ad), fontSize: 12),
        button: TextStyle(
            color: Color(0xffFAD703),
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
    ),
  );

  final cupertinoTheme = CupertinoThemeData(
    primaryColor: Color(0xff124559),
    barBackgroundColor: Color(0xff124559),
    scaffoldBackgroundColor: Color(0xff124559),
    brightness: Brightness.dark,
  );

  Widget _buildApp(BuildContext context) {
    if (Platform.isIOS) {
      return Theme(
        data: themeData,
        child: CupertinoApp.router(
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
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
