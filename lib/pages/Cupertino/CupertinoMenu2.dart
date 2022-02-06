import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'DarkModeColor.dart';
import 'CupertinoHelloWorld.dart';
import 'CupertinoHome.dart';
import 'CupertinoListView.dart';
import 'CupertinoLocalAuthentication.dart';
import 'CupertinoLocalFile.dart';
import 'CupertinoMenuListView.dart';
import 'CupertinoPicker.dart';
import 'CupertinoPlatform.dart';
import 'CupertinoSegmentedControl.dart';
import 'CupertinoSharedPreferences.dart';
import 'CupertinoSignInButton.dart';
import 'CupertinoSnackBar.dart';
import 'CupertinoSqliteViewer.dart';

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
            CupertinoButton(
              child: Text("Push CupertinoLocalAuthentication"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoLocalAuthentication())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoLocalFile"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoLocalFile())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoMenuListView"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoMenuListView())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoPicker"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoPicker())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoPlatform"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoPlatform())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoSegmentedControl"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoSegmentedControl())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoSharedPreferences"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoSharedPreferences())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoSignInButton"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoSignInButton())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoSnackBar"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoSnackBar())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoSqliteViewer"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoSqliteViewer())
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
