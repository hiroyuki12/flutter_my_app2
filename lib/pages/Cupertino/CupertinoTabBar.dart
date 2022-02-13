import 'package:flutter/cupertino.dart';
import 'CupertinoHelloWorld.dart';
import 'CupertinoButton.dart';
import 'CupertinoAlertDialog.dart';
import 'CupertinoFlutterIssues.dart';
import 'DarkModeColor.dart';

class MyCupertinoTabBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MyCupertinoTabBar> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true;
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
            backgroundColor: isDarkMode ? darkModeBackColor : backColor,
            items: [
              BottomNavigationBarItem(
                backgroundColor: isDarkMode ? darkModeBackColor : backColor,
                icon: Icon(CupertinoIcons.home),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.bell),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.mail),
              ),
            ]),
        tabBuilder: (context, i) {
          if (i == 0)
            return CupertinoHelloWorld();
          else if (i == 1)
            return MyCupertinoButton();
          else if (i == 2)
            return MyCupertinoAlertDialog();
          else
            return CupertinoFlutterIssues();
        });
  }
}
