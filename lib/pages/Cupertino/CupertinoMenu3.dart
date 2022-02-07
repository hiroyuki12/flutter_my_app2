import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'DarkModeColor.dart';
import 'CupertinoSwitch.dart';
import 'CupertinoTabBar.dart';
import 'CupertinoTextField.dart';
import 'CupertinoTimerPicker.dart';
import 'CupertinoTwitter.dart';
import 'CupertinoTwitterHome.dart';
import 'CupertinoWebView.dart';
import 'CupertinoNavigationBar.dart';
import 'CupertinoSearchTextField.dart';

class CupertinoMenu3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CupertinoMenu3> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("Cupertino Menu3", style: _buildTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            CupertinoButton(
              child: Text("Push CupertinoSwitch"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoSwitch())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoTabBar"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoTabBar())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoTextField"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoTextField())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoTimerPicker"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoTimerPicker())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoTwitter"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoTwitter())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoTwitterHome"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoTwitterHome())
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
              child: Text("Push CupertinoNavigationBar"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoNavigationBar())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoSearchTextField"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoSearchTextField())
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
