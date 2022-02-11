import 'package:flutter/cupertino.dart';
import '../DarkModeColor.dart';

class BasicsContainer extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<BasicsContainer> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true;  // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor: isDarkMode ? darkModeBackColor : backColor,  //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDarkMode ? darkModeBackColor : backColor,  //white , darkMode=black
        middle: Text("Basics Container", style: _buildTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: Container(
        height: 500, // 高さ
        width: double.infinity, // 横幅
        color: Color.fromARGB(255, 255, 45, 85), // 背景色
        margin: EdgeInsets.all(20.0),  // ウィジェットの外側の余白
        padding: EdgeInsets.all(40.0), // ウィジェットの内側の余白
        alignment: Alignment.center,   // 子ウィジェットの配置
        child: Text('こんにちは', style: _buildTextStyle()),     // 子ウィジェット
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
