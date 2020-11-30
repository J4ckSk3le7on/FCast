import 'package:f_cast/src/ui/common/ui/platform_page.dart';
import 'package:f_cast/src/ui/main/cubit/authentication_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends PlatformPage {
  HomePage() : super(Home(), "/home");
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text("logout"),
            onPressed: () {
              var authCubit = BlocProvider.of<AuthenticationCubit>(context);
              authCubit.signOut();
            },
          ),
        ),
      ),
    );
  }
}
