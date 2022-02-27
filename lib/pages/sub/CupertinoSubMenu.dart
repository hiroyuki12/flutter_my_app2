import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../DarkModeColor.dart';
//import '../Firebase/CupertinoFirebaseSignup.dart';
import 'QrCodeReader/first_page_view.dart';
import 'CameraScreen.dart';

class CupertinoSub extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CupertinoSub> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("Cupertino Sub", style: _buildTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            CupertinoButton(
              child: const Text("QR code scanner"),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FirstPageView())),
            ),
            CupertinoButton(
              child: const Text("Camera"),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCamera())),
            ),
            /*CupertinoButton(
              child: Text("(Need API Key) Firebase(signup)"),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CupertinoFirebaseSignup())),
            ),*/

          ],
        ),
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
