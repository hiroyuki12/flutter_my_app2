import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/QiitaScreen.dart';
import 'pages/Cupertino/CupertinoMenu.dart';
import 'pages/Cupertino/CupertinoSub.dart';
import 'pages/Basics/BasicsMenu.dart';
import 'pages/CupertinoWebView.dart';
import 'pages/Firebase/CupertinoFirebase.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
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
        middle: Text("main", style: TextStyle(color: CupertinoColors.white)),
        backgroundColor: const Color(0xff333333),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
                child: Text("flutter.dev(外部サイト)"),
                onPressed: () async {
                  await _launchURL('https://flutter.dev');
                }),
            CupertinoButton(
                child: Text("環境構築(外部サイト)"),
                onPressed: () async {
                  await _launchURL(
                      'https://mbp.hatenablog.com/entry/2019/12/29/000000?_ga=2.97341151.1500483094.1644030611-1356087000.1644030611');
                }),
            CupertinoButton(
                child: Text("flutter_my_app2(外部サイト)"),
                onPressed: () async {
                  await _launchURL(
                      'https://mbp.hatenablog.com/entry/2022/02/05/143159');
                }),
            CupertinoButton(
              child: Text("Qiita(API)"),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Qiita())),
            ),
            CupertinoButton(
              child: Text("Cupertino Firebase"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CupertinoFirebase())),
            ),
            CupertinoButton(
                child: Text("Zenn(Flutter) 外部サイト"),
                onPressed: () async {
                  await _launchURL(
                      'https://zenn.dev/topics/flutter?order=latest');
                }),
            CupertinoButton(
                child: Text("Qiita(Flutter) 外部サイト"),
                onPressed: () async {
                  await _launchURL('https://qiita.com/tags/flutter');
                }),
            CupertinoButton(
                child: Text("はてなブログタグ(外部サイト)"),
                onPressed: () async {
                  await _launchURL('https://d.hatena.ne.jp/keyword/flutter');
                }),
            CupertinoButton(
              child: Text("sub ->"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CupertinoSub())),
            ),
            CupertinoButton(
              child: Text("Cupertino Menu ->"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CupertinoMenu())),
            ),
            CupertinoButton(
              child: Text("Basics Menu ->"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BasicsMenu())),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  await launch(url);
}
