import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'DarkModeColor.dart';
import 'CupertinoHelloWorld.dart';
import 'CupertinoHome.dart';
import 'CupertinoListView.dart';

class CupertinoMenu2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CupertinoMenu2> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("Cupertino Menu2", style: _buildTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            CupertinoButton(
              child: Text("Push CupertinoHome"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoHome())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoListView"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoListView())
                ),
            ),

          ],
        ),
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
    color: isDarkMode ? darkModeForeColor : foreColor, //black , darkMode=white
  );
}
