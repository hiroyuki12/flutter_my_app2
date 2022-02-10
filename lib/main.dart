import 'package:flutter/material.dart';
import 'pages/QiitaScreen.dart';
import 'package:flutter/cupertino.dart';
import 'pages/Cupertino/CupertinoMenu.dart';
import 'pages/CupertinoWebView.dart';

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
              child: Text("flutter.dev(外部サイト)"),
              onPressed: () =>
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                      MyCupertinoWebView(
                        url: "https://flutter.dev",
                        title: "flutter.dev"),
                  ),
                ),
            ),
            CupertinoButton(
              child: Text("環境構築(外部サイト)"),
              onPressed: () =>
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                      MyCupertinoWebView(
                        url: "https://mbp.hatenablog.com/entry/2019/12/29/000000?_ga=2.97341151.1500483094.1644030611-1356087000.1644030611",
                        title: "Flutter 入門"),
                  ),
                ),
            ),
            CupertinoButton(
              child: Text("flutter_my_app2(外部サイト)"),
              onPressed: () =>
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                      MyCupertinoWebView(
                        url: "https://mbp.hatenablog.com/entry/2022/02/05/143159",
                        title: "flutter_my_app2"),
                  ),
                ),
            ),
            CupertinoButton(
              child: Text("Qiita(API)"),
              onPressed: () =>
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Qiita())
                ),
            ),
            CupertinoButton(
              child: Text("Zenn(Flutter) 外部サイト"),
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
              child: Text("Qiita(Flutter) 外部サイト"),
              onPressed: () =>
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                      MyCupertinoWebView(
                        url: "https://qiita.com/tags/flutter",
                        title: "Qiita Flutterの記事一覧"),
                  ),
                ),
            ),
            CupertinoButton(
              child: Text("はてなブログタグ(外部サイト)"),
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
              child: Text("Cupertino Menu ->"),
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
