import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:url_launcher/url_launcher.dart';
import 'Constants.dart';
import 'DarkModeColor.dart';

class Twitter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
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

class _State extends State<Twitter> {
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  List<Item> _items = <Item>[];
  int _savedPage = 1;
  var _maxId = "0";
  var _imagesCount = 0;
  //double _pageMaxScrollExtend = 877.0; // Simulator iPhone 13, _perPage 20の時
  double _pageMaxScrollExtend = 19877.0; // Simulator iPhone 13, 200の時 
  double _maxScrollExtend = 19877.0;

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
    _scrollController.addListener(_scrollListener);
    _load();
  }

  void _scrollListener() {
    // スクロールを検知したときに呼ばれる
    double positionRate =
        //_scrollController.offset / _scrollController.position.maxScrollExtent;
        (_scrollController.offset - (_pageMaxScrollExtend * (_savedPage - 1))) /
            _maxScrollExtend;

    if (positionRate > 0.99) {
      if (_isLoading == false) {
        _isLoading = true;
        _savedPage++;
        _load();
        print('_load');
        print(positionRate);  // debug
      }
    } else {
      _isLoading = false;
      //print(_maxScrollExtend);
      //print(positionRate);  // debug
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  Future<void> _load() async {
    print('_load() start');
    final client = oauth1.Client(
      platform.signatureMethod,
      clientCredentials,
      oauth1.Credentials(
        Constants.twitterAccessToken,       // 'Twitter Access Token をここに設定',
        Constants.twitterAccessTokenSecret, // 'Twitter Access Token Secret をここに設定',
      ),
    );
    var url;
    //var _screenName = 'twitterjp';
    var _screenName = Constants.twitterScreenName;
    if(_maxId == '0')
    {
      url = 'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=' + _screenName + '&count=200&exclude_replies=true';
    }
    else
    {
      url = 'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=' + _screenName + '&count=200&max_id=' + _maxId;
      //print('url');
      //print(url);
    } 
    final apiResponse = await client.get(Uri.parse(url),);
    final data = json.decode(apiResponse.body);
    final List<String> _images = [];

    setState((){
      final items = data as List;
      items.forEach((dynamic element) {
        final issue = element as Map;
        try {
          for (var _url in issue['extended_entities']['media']) {
            _images.add(_url['media_url']);
          }
          _imagesCount = _images.length;
          //print(_imagesCount);
        }
        catch (e) {
        }
        _items.add(Item(
          id_str: issue['id_str'] as String,
          //text:   issue['text'] as String,
          //favorite_count:   issue['favorite_count'] as int,
          //retweet_count:   issue['retweet_count'] as int,
          //profile_image_url:   issue['user']['profile_image_url'] as String,
          //is_quote_status:   issue['is_quote_status'] as bool,
          image: _images,
        ));
      });
      _maxId = _items[_items.length-1].id_str as String;
      print('_maxId');
      print(_maxId);
      print('_imagesCount');
      print(_imagesCount);
    });
    //print(apiResponse.body);
    //print(_items[0].text);
    //print('aa');
    //print(_items[0].image);
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
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  final issue = _items[index];
                  return Row(
                    children: <Widget>[
                      //Text(index.toString(), style: _buildTextStyle()),
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
                      ),
                    ]
                  );
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
