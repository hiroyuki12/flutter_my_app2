import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:url_launcher/url_launcher.dart';
import 'Constants.dart';
import 'DarkModeColor.dart';

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
    this.favorite_count,
    this.retweet_count,
    this.profile_image_url,
    this.is_quote_status,
    this.image,
  });

  final String? id_str;
  final String? text;
  final int? favorite_count;
  final int? retweet_count;
  final String? profile_image_url;
  final bool? is_quote_status;
  final List<String>? image;
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<Item> _items = <Item>[];

  final platform = oauth1.Platform(
    'https://api.twitter.com/oauth/request_token',
    'https://api.twitter.com/oauth/authorize',
    'https://api.twitter.com/oauth/access_token',
    oauth1.SignatureMethods.hmacSha1,
  );
  final clientCredentials = oauth1.ClientCredentials(
    Constants.twitterAPIkey,       //'Twitter API Key をここに設定',
    Constants.twitterAPIsecretKey, //'Twitter API Key Secret をここに設定',
  );

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final client = oauth1.Client(
      platform.signatureMethod,
      clientCredentials,
      oauth1.Credentials(
        Constants.twitterAccessToken,       // 'Twitter Access Token をここに設定',
        Constants.twitterAccessTokenSecret, // 'Twitter Access Token Secret をここに設定',
      ),
    );
    final apiResponse = await client.get(
      Uri.parse(
        //'https://api.twitter.com/1.1/statuses/home_timeline.json?count=30'),
        //'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=twitterjp&count=30'),
        'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=twitterjp&count=200&exclude_replies=true'),
        //'https://api.twitter.com/1.1/search/tweets.json?q=flutter&lang=ja&count=30'),
    );
    final data = json.decode(apiResponse.body);
    final List<String> _images = [];

    setState((){
      final items = data as List;
      //List<Item> _items = <Item>[];
      items.forEach((dynamic element) {
        final issue = element as Map;
        try {
          _images.add(issue['entities']['media'][0]['media_url']);
          /*for (var _url in issue['extended_entities']['media']) {
            _images.add(_url['media_url']);
          }*/
        }
        catch (e) {
        }
        _items.add(Item(
          //id_str: issue['id_str'] as String,
          text:   issue['text'] as String,
          favorite_count:   issue['favorite_count'] as int,
          retweet_count:   issue['retweet_count'] as int,
          profile_image_url:   issue['user']['profile_image_url'] as String,
          is_quote_status:   issue['is_quote_status'] as bool,
          image: _images,
          //image1:   issue['entities']['media'][0]['media_url_https'] as String,
        ));
      });
    });
    //print(apiResponse.body);
    //print(_items[0].text);
    print('aa');
    print(_items[0].image);
    //print(_items[1].text);
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = true;
    return CupertinoPageScaffold(
      backgroundColor: isDarkMode ? darkModeBackColor : backColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDarkMode ? darkModeBackColor : backColor,
        middle: Text("Twitter", style: _buildTextStyle()),
      ),
      child: (_items == null || _items.length == 0)
        ? Text("Loading....", style: _buildTextStyle())
        : Column(children: [
            Flexible(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final issue = _items[index];
                  //if(issue.is_quote_status!)
                  {
                    return Row(
                      children: <Widget>[
                        Expanded(
                          //child: Text(issue.text!, style: _buildTextStyle())
                          //child: Text(issue.favorite_count!.toString(), style: _buildTextStyle())
                          //child: Text(issue.retweet_count!.toString(), style: _buildTextStyle())
                          //child: Text(issue.profile_image_url!, style: _buildTextStyle())
                          //child: Text(issue.image![index], style: _buildTextStyle())
                          child: Image.network(
                            issue.image![index],
                            width: 210,
                          ),
                        )
                      ]
                    );
                  }
                }
              )
            )
         ])
    );
  }
}

var myTextStyle = TextStyle();
TextStyle _buildTextStyle() {
  return myTextStyle = TextStyle(
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.none,
    fontSize: 16,
    color: CupertinoColors.white,
  );
}
