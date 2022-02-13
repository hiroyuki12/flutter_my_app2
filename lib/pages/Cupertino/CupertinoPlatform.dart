import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'DarkModeColor.dart';

class CupertinoPlatform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CupertinoPlatform> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("CuperinoPlatform", style: _buildFont()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: Center(
        child: Text(
          Platform.isIOS ? "iOS!" : "Not iOS!",
          style: _buildFont(),
        ),
      ),
    );
  }
}

var myTextStyle = TextStyle();
TextStyle _buildFont() {
  return myTextStyle = TextStyle(
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.none,
    fontSize: 16,
    // color: CupertinoColors.white
    color: isDarkMode ? darkModeForeColor : foreColor, //black , darkMode=white
  );
}
