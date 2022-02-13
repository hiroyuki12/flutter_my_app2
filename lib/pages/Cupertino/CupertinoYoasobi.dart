import 'package:flutter/cupertino.dart';
import 'DarkModeColor.dart';
import 'package:url_launcher/url_launcher.dart';

class CupertinoYoasobi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CupertinoYoasobi> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("Cupertino Hello World", style: _buildTitleTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: Center(
        child: CupertinoButton(
          //color: CupertinoColors.activeBlue,
          //borderRadius: new BorderRadius.circular(30.0),
          onPressed: () async {
            await _launchURL('https://www.youtube.com/watch?v=by4SYYWlhEs');
          },
          child: Text('夜に駆ける', style: _buildTextStyle()),
        ),
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  await launch(url);
}

var myTitleTextStyle = TextStyle();
TextStyle _buildTitleTextStyle() {
  return myTitleTextStyle = TextStyle(
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.none,
    fontSize: 16,
    color: isDarkMode ? darkModeForeColor : foreColor, //black , darkMode=white
  );
}

var myTextStyle = TextStyle();
TextStyle _buildTextStyle() {
  return myTextStyle = TextStyle(
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.none,
    fontSize: 16,
    //color: isDarkMode ? darkModeForeColor : foreColor,  //black , darkMode=white
    color: Color.fromARGB(255, 255, 45, 85),
  );
}
