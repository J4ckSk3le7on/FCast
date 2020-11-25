import 'package:f_cast/src/ui/common/ui/platform_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends PlatformPage {
  AuthenticationPage() : super(AuthenticationWidget(), "/auth");
}

class AuthenticationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Sign in"),
        ),
      ),
    );
  }
}
