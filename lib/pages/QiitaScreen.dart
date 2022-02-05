import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Qiita extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class Item {
   Item({
     this.title,
     this.profileImageUrl,
   });

   final String? title;
   final String? profileImageUrl;
 }

class _State extends State<Qiita> {
  List<Item> _items = <Item>[];
  @override
  void initState() {
    super.initState();
    _load();
  }
  
  // This widget is the root of your application.
  Future<void> _load() async {
    //final res = await http.get(Uri.parse('https://qiita.com/api/v2/items'));
    final res = await http.get(Uri.parse('https://qiita.com/api/v2/tags/Flutter/items?page=1&per_page=20'));
    final data = json.decode(res.body);
    setState(() {
      final issues = data as List;
      issues.forEach((dynamic element) {
        final issue = element as Map;
        _items.add(Item(
          title: issue['title'] as String,
          profileImageUrl: issue['user']['profile_image_url'] as String,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qiita"),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index >= _items.length) {
            //return null;
            return ListTile(
              title: Text(""),
            );
          }

          final issue = _items[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(issue.profileImageUrl!),
            ),
            title: Text(issue.title!),
          );
        },
      ),
    );
  }
}
