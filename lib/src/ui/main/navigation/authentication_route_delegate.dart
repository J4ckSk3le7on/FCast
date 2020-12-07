import 'package:f_cast/src/ui/common/ui/splash_screen.dart';
import 'package:f_cast/src/ui/home/widgets/home.dart';
import 'package:f_cast/src/ui/login/ui/authentication_page.dart';
import 'package:f_cast/src/ui/main/cubit/authentication_cubit.dart';
import 'package:f_cast/src/ui/onboarding/ui/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationRouterDelegate extends RouterDelegate<AuthenticationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AuthenticationState> {
  final GlobalKey<NavigatorState> navigatorKey;
  AuthenticationState _currentState = AuthenticationState.loading();

  AuthenticationRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<Page<dynamic>> getPages() {
    List<Page<dynamic>> pages = [];
    _currentState.when(
      loading: () => pages.add(SplashPage()),
      signedOut: () => pages.add(AuthenticationPage()),
      signedIn: () => pages.add(HomePage()),
      onboarding: () => pages.add(OnboardingPage()),
    );
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AuthenticationCubit>(context);
    _currentState = cubit.state;
    return BlocListener(
      cubit: cubit,
      listener: (_, AuthenticationState state) {
        _currentState = state;
        notifyListeners();
      },
      child: Navigator(
        pages: getPages(),
        onPopPage: (result, route) => false,
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(AuthenticationState configuration) async {
    _currentState = configuration;
    notifyListeners();
  }
}
