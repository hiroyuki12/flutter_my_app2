import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'DarkModeColor.dart';

class MyCupertinoWebView extends StatefulWidget {
  MyCupertinoWebView({Key? key, this.url, this.title}) : super(key: key);

  final String? url;
  final String? title;

  @override
  _State createState() => _State();
}

class _State extends State<MyCupertinoWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool _isLoading = false;
  String _title = '';

  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("CupertinoWebView", style: _buildTextStyle()),
        trailing: GestureDetector(
          onTap: () => FlutterShare.share(
              title: 'title', text: widget.title, linkUrl: widget.url),

          // chooserTitle: widget.title),
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
            initialUrl: widget.url,
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
