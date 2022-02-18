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
  final controller = TextEditingController();
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
  late final auth = oauth1.Authorization(clientCredentials, platform);
  oauth1.Credentials? tokenCredentials;

  @override
  void initState() {
    super.initState();

    // CallbackURLを"oob"とすることでPINでの認証とできる
    auth.requestTemporaryCredentials('oob').then((res) {
      tokenCredentials = res.credentials;
      // launch() で ログイン用URLを開く
      launch(auth.getResourceOwnerAuthorizationURI(tokenCredentials!.token));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ログイン後に表示されたPINを入力
            TextFormField(
              controller: controller,
            ),
            ElevatedButton(
              onPressed: () async {
                // 入力されたPINを元に Access Token を取得
                final pin = controller.text;
                final verifier = pin;
                final res = await auth.requestTokenCredentials(
                  tokenCredentials!,
                  verifier,
                );
                print('Access Token: ${res.credentials.token}');
                print('Access Token Secret: ${res.credentials.tokenSecret}');

                // 取得した Access Token を使ってAPIにリクエストできる
                final client = oauth1.Client(
                  platform.signatureMethod,
                  clientCredentials,
                  res.credentials,
                );
                final apiResponse = await client.get(
                  Uri.parse(
                      'https://api.twitter.com/1.1/statuses/home_timeline.json?count=1'),
                );

                final data = json.decode(apiResponse.body);
                final items = data as List;
                List<Item> _items = <Item>[];
                items.forEach((dynamic element) {
                  final issue = element as Map;
                  _items.add(Item(
                    id_str: issue['id_str'] as String,
                    text: issue['text'] as String,
                  ));
                });

                //print(apiResponse.body);
                print(_items[0].text);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
