import 'package:flutter/cupertino.dart';
import 'DarkModeColor.dart';

class MyCupertinoActionSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MyCupertinoActionSheet> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("CupertinoActionSheet", style: _buildTextStyle()),
      ),
      child: Center(
        child: _buildCupertinoButton(context),
      ),
    );
  }
}

Widget _buildCupertinoButton(BuildContext context) {
  return CupertinoButton(
    onPressed: () {
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return CupertinoActionSheet(
              title: Text("Hobbies"),
              message: Text("Select your hobbie"),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Text("Coding"),
                  onPressed: () {},
                ),
                CupertinoActionSheetAction(
                  child: Text("Main Game"),
                  onPressed: () {},
                ),
                CupertinoActionSheetAction(
                  child: Text("Menulis"),
                  onPressed: () {},
                ),
              ],
            );
          });
    },
    child: Text("Tap me"),
  );
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
