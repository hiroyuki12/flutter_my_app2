import 'package:flutter/cupertino.dart';

import 'DarkModeColor.dart';

class MyCupertinoPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MyCupertinoPicker> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("CupertinoPicker", style: _buildFont()),
      ),
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return Container(
                    height: 300.0,
                    child: CupertinoPicker(
                      backgroundColor: backColor,
                      onSelectedItemChanged: (value) {},
                      itemExtent: 30.0,
                      children: <Widget>[
                        Center(child: Text("item 1")),
                        Center(child: Text("item 2")),
                        Center(child: Text("item 3")),
                        Center(child: Text("item 4")),
                        Center(child: Text("item 5")),
                      ],
                    ),
                  );
                });
          },
          child: Text("Tap me"),
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
