import 'package:f_cast/src/ui/common/ui/platform_page.dart';
import 'package:flutter/material.dart';

class HomePage extends PlatformPage {
  HomePage() : super(Home(), "/home");
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("home"),
        ),
      ),
    );
  }
}
