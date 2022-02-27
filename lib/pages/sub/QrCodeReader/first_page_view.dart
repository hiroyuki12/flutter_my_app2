import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'confirm_view.dart';
import 'qr_code_scanner_view.dart';
import '../../DarkModeColor.dart';

class Const {
  //static const routeFirstPage = '/home';
  //static const routeQRCodeScanner = '/qr-code-scanner';
  static const routeConfirm = '/confirm';
}

class FirstPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<FirstPageView> {
  @override
  Widget build(BuildContext context) {
    isDarkMode = true;
    return CupertinoPageScaffold(
      backgroundColor: isDarkMode ? darkModeBackColor : backColor,
      navigationBar: CupertinoNavigationBar(
        middle: Text("QR code scanner", style: _buildTextStyle()),
        backgroundColor: isDarkMode ? darkModeBackColor : backColor,
      ),
      child: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Center(
      child: CupertinoButton(
        onPressed: () {
          //if (await Permission.camera.request().isGranted) {
            Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QRCodeScannerView()));
          //} else {
          //  await showRequestPermissionDialog(context);
          //}
        },
        child: Text('Launch QR code scanner', style: _buttonTextStyleNoBackground),
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
  color: isDarkMode ? darkModeForeColor : foreColor,
  );
}

TextStyle _buttonTextStyleNoBackground = new TextStyle(
  fontWeight: FontWeight.w300,
  decoration: TextDecoration.none,
  fontSize: 16,
  color: CupertinoColors.activeBlue,
);
