import 'package:f_cast/src/injectible/injectible_init.dart';
import 'package:f_cast/src/ui/common/ui/splash_screen.dart';
import 'package:f_cast/src/ui/main/ui/main.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  runApp(FCast());
}

class FCast extends StatefulWidget {
  @override
  _FCastState createState() => _FCastState();
}

class _FCastState extends State<FCast> {
  bool initFinished = false;

  void initState() {
    super.initState();
    _initState();
  }

  Future<void> _initState() async {
    await configureDependencies();
    //we have some dependencies we need to await for as well
    await GetIt.instance.allReady();
    setState(() {
      initFinished = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (initFinished) {
      return Main();
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    }
  }
}
