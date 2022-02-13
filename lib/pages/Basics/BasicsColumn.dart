import 'package:flutter/cupertino.dart';
import '../DarkModeColor.dart';

class BasicsColumn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<BasicsColumn> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("Basics Column", style: _buildTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Hello World!",
            style: _buildTextStyle(),
          ),
          Text(
            "Hello World!",
            style: _buildTextStyle(),
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
