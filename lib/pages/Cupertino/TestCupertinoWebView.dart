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
  late final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(
      onPageStarted: (String url) {
        setState(() {
          _isLoading = true;
        });
      },
      onPageFinished: (String url) async {
        setState(() {
          _isLoading = false;
        });
        final title = await _controller.getTitle();
        setState(() {
          if (title != null) {
            _title = title;
          }
        });
      },
    ))
    ..loadRequest(Uri.parse('https://flutter.dev'));

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
        child: WebViewWidget(controller: _controller), //WebView
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
