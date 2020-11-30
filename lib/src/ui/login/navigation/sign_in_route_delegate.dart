import 'package:f_cast/src/ui/login/cubit/sign_in_cubit.dart';
import 'package:f_cast/src/ui/login/ui/login_with_email.dart';
import 'package:f_cast/src/ui/login/ui/register_with_email.dart';
import 'package:f_cast/src/ui/login/ui/select_login.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInRouteDelegate extends RouterDelegate<SignInState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<SignInState> {
  final GlobalKey<NavigatorState> navigatorKey;
  SignInState _currentState = SignInState.selectLogin();

  SignInRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<Page<dynamic>> getPages() {
    List<Page<dynamic>> pages = [SelectLoginPage()];
    _currentState.maybeWhen(
      orElse: () {},
      login: () => pages.add(LoginWithEmailPage()),
      register: () => pages.add(RegisterWithEmailPage()),
    );
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      cubit: BlocProvider.of<SignInCubit>(context),
      listener: (_, SignInState state) {
        _currentState = state;
        notifyListeners();
      },
      child: Navigator(
        pages: getPages(),
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          return _currentState.when(
            selectLogin: () => false,
            login: () => true,
            register: () => true,
          );
        },
      ),
    );
  }

  @override
  Future<void> setNewRoutePath(SignInState configuration) async {
    _currentState = configuration;
    notifyListeners();
  }
}
