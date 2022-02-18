import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:url_launcher/url_launcher.dart';

/*void main() {
  runApp(MyApp());
}*/

class Twitter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyWidget(),
    );
  }
}

class Item {
  Item({
    this.id_str,
    this.text,
  });

  final String? id_str;
  final String? text;
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final platform = oauth1.Platform(
    'https://api.twitter.com/oauth/request_token',
    'https://api.twitter.com/oauth/authorize',
    'https://api.twitter.com/oauth/access_token',
    oauth1.SignatureMethods.hmacSha1,
  );
  final clientCredentials = oauth1.ClientCredentials(
    'Twitter API Key をここに設定',
    'Twitter API Key Secret をここに設定',
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Access Token を使ってAPIにリクエストできる
                final client = oauth1.Client(
                  platform.signatureMethod,
                  clientCredentials,
                  oauth1.Credentials(
                    'Twitter Access Token をここに設定',
                    'Twitter Access Token Secret をここに設定',
                  ),
                );
                final apiResponse = await client.get(
                  Uri.parse(
                      //'https://api.twitter.com/1.1/statuses/home_timeline.json?count=1'),
                      //'https://api.twitter.com/1.1/search/tweets.json?q=flutter&lang=ja&count=1'),
                      'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=twitterjp&count=2'),
                );

                final data = json.decode(apiResponse.body);
                final items = data as List;
                List<Item> _items = <Item>[];
                items.forEach((dynamic element) {
                  final issue = element as Map;
                  _items.add(Item(
                    id_str: issue['id_str'] as String,
                    text:   issue['text'] as String,
                  ));
                });

                //print(apiResponse.body);
                print(_items[0].text);
                print(_items[1].text);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
