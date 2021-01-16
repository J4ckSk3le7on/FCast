import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformScaffold extends StatelessWidget {
  final Widget child;
  final CupertinoNavigationBar cupertinoNavigationBar;
  final BottomNavigationBar bottomNavigationBar;
  final CupertinoTabBar cupertinoTabBar;
  final AppBar materialAppBar;
  final IndexedWidgetBuilder tabBuilder;

  const PlatformScaffold({
    Key key,
    this.cupertinoNavigationBar,
    this.materialAppBar,
    @required this.child,
    this.bottomNavigationBar,
    this.cupertinoTabBar,
    this.tabBuilder,
  })  : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS && cupertinoTabBar == null) {
      return Material(
        child: SafeArea(
          child: CupertinoPageScaffold(
            navigationBar: cupertinoNavigationBar,
            child: child,
          ),
        ),
      );
    } else if (Platform.isIOS && cupertinoTabBar != null) {
      return Material(
        child: SafeArea(
          child: CupertinoTabScaffold(
            tabBar: cupertinoTabBar,
            tabBuilder: tabBuilder,
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: materialAppBar,
          body: child,
          bottomNavigationBar: bottomNavigationBar,
        ),
      );
    }
  }
}
