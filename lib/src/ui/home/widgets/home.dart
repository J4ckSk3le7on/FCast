import 'package:f_cast/src/ui/common/ui/platform_page.dart';
import 'package:f_cast/src/ui/home/home/ui/home_page.dart';
import 'package:f_cast/src/ui/home/search/ui/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/ui/platform_scaffold.dart';

class HomePage extends PlatformPage {
  HomePage() : super(Home(), "/home");
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  List<BottomNavigationBarItem> _getNavigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
  ];

  List<Widget> _pages = [
    PodcastHomePage(),
    SearchPage(),
  ];

  Widget tabBuilder(BuildContext context, int index) {
    return _pages[index];
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      child: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _getNavigationItems,
      ),
      tabBuilder: tabBuilder,
      cupertinoTabBar: CupertinoTabBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        activeColor: Colors.white,
        inactiveColor: Colors.grey.shade400,
        items: _getNavigationItems,
      ),
    );
  }
}
