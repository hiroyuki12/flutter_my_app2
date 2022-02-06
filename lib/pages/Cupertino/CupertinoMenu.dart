import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'DarkModeColor.dart';
import 'TestCupertinoWebView.dart';
import 'CupertinoButton.dart';
import 'CupertinoActionSheet.dart';
import 'CupertinoActivityIndicator.dart';
import 'CupertinoAlertDialog.dart';
import 'CupertinoBuildingLayouts.dart';
import 'CupertinoClose.dart';
import 'CupertinoWebView.dart';
import 'CupertinoDarkModeFlag.dart';
import 'CupertinoDatePicker.dart';
import 'CupertinoFlutterIssues.dart';
import 'CupertinoGridView.dart';

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
            CupertinoButton(
              child: Text("Push CupertinoAlertDialog"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoAlertDialog())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoBuildingLayouts"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoBuildingLayouts())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoClose"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoClose())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoWebView"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoWebView(
                    url: "http://www.google.com", title: "CupertinoWebView"))
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoDarkModeFlag"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoDarkModeFlag())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoDatePicker"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoDatePicker())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoFlutterIssues"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoFlutterIssues())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoGridView"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoGridView())
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
