import 'package:flutter/cupertino.dart';

import 'DarkModeColor.dart';

class MyCupertinoNavigationBar extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MyCupertinoNavigationBar> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true;  // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor: isDarkMode ? darkModeBackColor : backColor,  //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        middle: Text("CupertinoNavigationBar", style: _buildTextStyle()),
        backgroundColor: isDarkMode ? darkModeBackColor : backColor,  //white , darkMode=black
      ),
      child: Center(
      ),
    );
  }
}

var myTextStyle = new TextStyle();
TextStyle _buildTextStyle() {
  return myTextStyle = new TextStyle(
  fontWeight: FontWeight.w100,
  decoration: TextDecoration.none,
  fontSize: 16,
  // color: CupertinoColors.white
  color: isDarkMode ? darkModeForeColor : foreColor,  //black , darkMode=white
  );
}
