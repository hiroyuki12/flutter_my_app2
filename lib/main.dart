import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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

class Item {
  Item({
    this.title,
  });

  final String? title;
}

class Issue {
  Issue({
    this.title,
    this.avatarUrl,
  });

  final String? title;
  final String? avatarUrl;
}

class _MyHomePageState extends State<MyHomePage> {
  String _data = '';
  List<String> _titles = <String>[];
  List<Issue> _issues = <Issue>[];
  List<Item> _qiitaItems= <Item>[];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    //String url = 'https://api.github.com/repositories/31792824/issues';
    //final res = await http.get(Uri.parse(url));
    //final data = json.decode(res.body);
    String url = 'http://qiita.com/api/v2/items';
    final res = await http.get(Uri.parse(url));
    final data = json.decode(res.body);

    setState(() {
      //_data = res.body;

      final qiitaItems = data as List;
      qiitaItems.forEach((dynamic element) {
        final qiitaItem = element as Map;
        _qiitaItems.add(Item(
          title: qiitaItem['title'] as String,
        ));
      });

      /*
      final issues = data as List;
      issues.forEach((dynamic element) {
        final issue = element as Map;
        _titles.add(issue['title'] as String);
        _issues.add(Issue(
          title: issue['title'] as String,
          avatarUrl: issue['user']['avatar_url'] as String,
        ));
      });
      */

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          //if (index >= _qiitaItems.length) {
          //  return null;
          //}

          final qiitaItem = _qiitaItems[index];
          return ListTile(
            title: Text(qiitaItem.title!),
          );

          /*
          final issue = _issues[index];
          return ListTile(
            leading: ClipOval(
              child: Image.network(issue.avatarUrl!),
            ),
            title: Text(issue.title!),
          );
          */
        },
      ),
      
    );
  }
}
