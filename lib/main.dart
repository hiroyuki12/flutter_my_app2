import 'package:flutter/material.dart';
import 'pages/QiitaScreen.dart';
import 'pages/CupertinoButton.dart';
import 'package:flutter/cupertino.dart';

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
              child: Text("Push Qiita(API) Flutter"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Qiita())
                ),
            ),
            CupertinoButton(
              child: Text("Push CupertinoButton"),
              onPressed: () => 
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyCupertinoButton())
                ),
            ),
          ],
        ),
      ),
    );
  }
}
