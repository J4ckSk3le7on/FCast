import 'package:f_cast/src/ui/common/ui/platform_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends PlatformPage {
  SplashPage() : super(SplashScreen(), "/splash");
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xff1200BE),
              Color(0xffC768D7),
            ],
            radius: 10,
          ),
        ),
        child: Center(
          child: Text("F Cast"),
        ),
      ),
    );
  }
}
