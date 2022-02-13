import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../DarkModeColor.dart';

class MyCupertinoIcons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MyCupertinoIcons> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("Basics Icon", style: _buildTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            CupertinoIcons.heart_fill,
            color: Colors.pink,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          Icon(
            CupertinoIcons.heart,
            color: Colors.pink,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          Icon(
            CupertinoIcons.bell_fill,
            color: Colors.green,
            size: 30.0,
          ),
          Icon(
            CupertinoIcons.umbrella_fill,
            color: Colors.blue,
            size: 36.0,
          ),
        ],
      ),
    );
  }
}

var myTextStyle = TextStyle();
TextStyle _buildTextStyle() {
  return myTextStyle = TextStyle(
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.none,
    fontSize: 16,
    color: isDarkMode ? darkModeForeColor : foreColor, //black , darkMode=white
  );
}
