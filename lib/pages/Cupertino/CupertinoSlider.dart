import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DarkModeColor.dart';

class MyCupertinoSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MyCupertinoSlider> {
  double rating = 40.0;

  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode

    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("CupertinoSwitch", style: _buildTextStyle()),
      ),
      child: Row(
        children: [
          Text(
            "${rating.round()}",
            style: _buildTextStyle(),
          ),
          CupertinoSlider(
            value: rating,
            onChanged: (newRating) {
              setState(() {
                rating = newRating;
              });
            },
            min: 0,
            max: 100,
            divisions: 50,
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
