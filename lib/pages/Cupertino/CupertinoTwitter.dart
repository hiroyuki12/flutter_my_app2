import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CupertinoTabBar.dart';
import 'CupertinoTwitterHome.dart';
import 'DarkModeColor.dart';

class CupertinoTwitter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CupertinoTwitter> {
  List<Widget> _pages = [
    CupertinoTwitterHome(),

    ///Home画面以外は,　今後作成する
    MyCupertinoTabBar(),
    Container(),
    Container(),
  ];
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoTabScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      tabBar: _buildTabBar(),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoPageScaffold(child: _pages[index]);
      },
    );
  }

  CupertinoTabBar _buildTabBar() {
    return CupertinoTabBar(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //darkMode = black
      activeColor: Colors.blue,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: 28.0),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, size: 27.0),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none, size: 27.0),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail_outline, size: 27.0),
        ),
      ],
    );
  }
}

var myTextStyle = TextStyle(
  fontWeight: FontWeight.w100,
  decoration: TextDecoration.none,
  fontSize: 16,
  //color: CupertinoColors.white);
);
