import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_share/flutter_share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'DarkModeColor.dart';

class TestCupertinoWebView extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TestCupertinoWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool _isLoading = false;
  String _title = '';

  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      // backgroundColor: isDarkMode ? darkModeBackColor : backColor,  //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        middle: Text("TestCupertinoWebView", style: _buildTextStyle()),
        trailing: GestureDetector(
          child: Icon(
            CupertinoIcons.share,
            color: CupertinoColors.systemGrey,
          ),
        ),
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      ),
      child: Center(
        child: WebView(
            initialUrl: 'https://flutter.dev',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: _controller.complete,
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (String url) async {
              setState(() {
                _isLoading = false;
              });
              final controller = await _controller.future;
              final title = await controller.getTitle();
              setState(() {
                if (title != null) {
                  _title = title;
                }
              });
            }), //WebView
      ), //Center
    ); //CupertinoPageScaffold
  } //build
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
