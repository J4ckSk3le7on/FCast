import 'package:f_cast/src/ui/common/ui/platform_page.dart';
import 'package:f_cast/src/ui/common/ui/platform_scaffold.dart';
import 'package:flutter/material.dart';

class SplashPage extends PlatformPage {
  SplashPage() : super(SplashScreen(), "/splash");
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      child: Container(),
    );
  }
}
