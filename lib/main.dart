import 'package:flutter/material.dart';
import 'pages/QiitaScreen.dart';
import 'pages/TestCupertinoWebView.dart';
import 'package:flutter/cupertino.dart';
import 'pages/Cupertino/CupertinoMenu.dart';
import 'pages/CupertinoWebView.dart';
import 'pages/Cupertino/CupertinoButton.dart';
import 'pages/Cupertino/CupertinoActionSheet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("main", style: new TextStyle(color: CupertinoColors.white)),
        backgroundColor: const Color(0xff333333),
      ),

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              child: Text("Push Qiita(API)"),
              onPressed: () =>
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Qiita())
                ),
            ),
            CupertinoButton(
              child: Text("Push Zenn(外部サイト)"),
              onPressed: () =>
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                      MyCupertinoWebView(
                        url: "https://zenn.dev/topics/flutter?order=latest",
                        title: "Zenn Flutterの記事一覧"),
                  ),
                ),
            ),
            CupertinoButton(
              child: Text("Push Qiita(外部サイト)"),
              onPressed: () =>
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                      MyCupertinoWebView(
                        url: "https://qiita.com/tags/react",
                        title: "Qiita Flutterの記事一覧"),
                  ),
                ),
            ),
            CupertinoButton(
              child: Text("Push はてなブログタグ(外部サイト)"),
              onPressed: () =>
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                      MyCupertinoWebView(
                        url: "https://d.hatena.ne.jp/keyword/flutter",
                        title: "はてなブログタグ Flutter"),
                  ),
                ),
            ),
            CupertinoButton(
              child: Text("Push Cupertino Menu"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CupertinoMenu())
                ),
            ),
          ],
        ),
      ),
    );
  }
}
