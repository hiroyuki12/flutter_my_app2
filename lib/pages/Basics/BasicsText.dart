import 'package:flutter/cupertino.dart';
import '../DarkModeColor.dart';

class BasicsText extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<BasicsText> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true;  // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor: isDarkMode ? darkModeBackColor : backColor,  //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDarkMode ? darkModeBackColor : backColor,  //white , darkMode=black
        middle: Text("Basics Text", style: _buildTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: Text(
        'こんにちは',
        style: TextStyle(
          fontSize: 30.0, // 文字サイズ
          fontWeight: FontWeight.bold, // 文字の太さ
          color: Color.fromARGB(255, 255, 45, 85), // 文字の色
          letterSpacing: 3.0, // 文字と文字のスペース
          fontFamily: 'Lato', // フォントの種類
          decoration: TextDecoration.none,
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
  color: isDarkMode ? darkModeForeColor : foreColor,  //black , darkMode=white
  );
}
