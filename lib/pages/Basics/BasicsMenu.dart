import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../DarkModeColor.dart';
import 'BasicsColumn.dart';
import 'BasicsRow.dart';
import 'BasicsContainer.dart';
import 'BasicsText.dart';
import 'BasicsIcon.dart';

class BasicsMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<BasicsMenu> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("Basics Menu", style: _buildTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            CupertinoButton(
              child: Text("Push BasicsColumn"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BasicsColumn())),
            ),
            CupertinoButton(
              child: Text("Push BasicsRow"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BasicsRow())),
            ),
            CupertinoButton(
              child: Text("Push BasicsContainer"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BasicsContainer())),
            ),
            CupertinoButton(
              child: Text("Push BasicsText"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BasicsText())),
            ),
            CupertinoButton(
              child: Text("Push BasicsIcon"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BasicsIcon())),
            ),
          ],
        ),
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
