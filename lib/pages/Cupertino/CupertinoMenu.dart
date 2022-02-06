import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'DarkModeColor.dart';
import 'CupertinoButton.dart';
import 'CupertinoActionSheet.dart';
import 'CupertinoActivityIndicator.dart';
import 'TestCupertinoWebView.dart';

class CupertinoMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CupertinoMenu> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("Cupertino Menu", style: _buildTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            CupertinoButton(
              child: Text("Push TestCupertinoWebView"),
              onPressed: () =>
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TestCupertinoWebView())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoButton"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoButton())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoActionSheet"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoActionSheet())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoActivityIndicator"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoActivityIndicator())
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
