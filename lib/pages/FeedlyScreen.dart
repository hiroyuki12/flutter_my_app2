import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'CupertinoWebView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Constants.dart';

class Feedly extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class Item {
  Item({
    this.title,
    this.profileImageUrl,
    this.daysAgo,
    this.url,
    this.continuation,
  });

  final String? title;
  final String? profileImageUrl;
  final String? daysAgo;
  final String? url;
  final String? continuation;
}

class _State extends State<Feedly> {
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  List<Item> _items = <Item>[];

  //final MyPage page = MyPage.newPage();

  int _sqliteSavedPage = 0;
  int _sqlliteSavedPerPage = 0;

  var _tag = 'hbfav';

  final _tagHbfav        = "hbfav";
  final _tagZennSwift    = "zennSwift";
  final _tagHatenaStuff  = "hatenastuff";

  int _savedPage = 1;
  int _perPage = 20;
  var _continuation = "99999999999999";
  double _pageMaxScrollExtend = 877.0; // Simulator iPhone 13, _perPage 20の時
  double _maxScrollExtend = 877.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _load(_savedPage, _perPage);
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
        _load(_savedPage, _perPage);
        print('_load');
        //print(positionRate);  // debug
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

  // This widget is the root of your application.
  Future<void> _load(int _page, int _perPage) async {
    var _category;
    if (_tag == _tagHbfav) {
      _category = 'c59b3cef-0fa1-414c-8aca-dc9678aaa85f';
    }
    else if (_tag == _tagZennSwift) {
      _category = '01328fc1-f342-4bae-b459-d613ff670195';
    }
    else {
      _category = '9b810adf-9db6-4600-8377-b04aec630ffc';
    }
    //var res;

    //final res = await http.get(Uri.parse('https://qiita.com/api/v2/items'));
    //final res = await http.get(Uri.parse('https://qiita.com/api/v2/tags/Flutter/items?page=1&per_page=20'));
    final res = await http.get(
      Uri.parse('https://cloud.feedly.com/v3/streams/contents?streamId=user/' +
        Constants.feedlyUserId +
        '/category/' +
        _category +
        '&continuation=' +
        _continuation),
      headers: {
        HttpHeaders.authorizationHeader: Constants.feedlyDeveloperToken,
      },
    );
    final data = json.decode(res.body);
    setState(() {
      final items = data['items'] as List;
      items.forEach((dynamic element) {
        final issue = element as Map;
        final profileImage = 'https://cdn.profile-image.st-hatena.com/users/' +
                               issue['author'] + '/profile.gif';
        int timestamp = issue['published'] as int;
        _items.add(Item(
          //continuation: issue['continuation'] as String,
          title: issue['title'] as String,
          profileImageUrl: profileImage,
          daysAgo: readTimestamp(timestamp),
          url: issue['alternate'][0]['href'] as String,
          // tags: issue['tags'] as List,
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.black,
          middle: Text(
              // "CupertinoQiita Page " +
              _tag +
                  " Page " +
                  _savedPage.toString() +
                  '/' +
                  _perPage.toString() +
                  'posts/' +
                  (((_savedPage - 1) * _perPage) + 1).toString() +
                  '~',
              style: _buildTextStyle()),
          trailing: CupertinoButton(
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildCupertinoActionSheet();
                  });
            },
            child: Text('menu'),
          ),
        ),
        child: (_items == null || _items.length == 0)
            ? Text(
                "Loading....",
                style: _buildTextStyle(),
              )
            : Column(children: [
                Flexible(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      //if (index >= _items.length) {
                      //  return null;
                      //}

                      final issue = _items[index];
                      return Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            // padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                            // child: ClipOval(
                            //   child: Image.network(issue.profileImageUrl,
                            //     width: 50,),
                            // ),
                            child: Image.network(
                              issue.profileImageUrl!,
                              width: 70,
                            ),
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Material(
                                //for InkWell
                                type: MaterialType.transparency,
                                child: InkWell(
                                  onTap: () async {
                                    await _launchURL(issue.url!);
                                  },
                                  child: Text(
                                    issue.title!,
                                    style: _buildTextStyle(),
                                  ),
                                ),
                              ),
                              Text(
                                issue.url!,
                                style: _buildSubTitleTextStyle(),
                              ),
                              Text(
                                issue.daysAgo!,
                                style: _buildSubTitleTextStyle(),
                              ),
                            ],
                          )),
                        ],
                      );
                    },
                  ),
                )
              ]));
  }

  Widget _buildCupertinoActionSheet() {
    return CupertinoActionSheet(
      //title: const Text('選択した項目が画面に表示されます'),
      actions: <Widget>[
        /*CupertinoActionSheetAction(
          child: const Text('Clear'),
          onPressed: () {
            // _savedPage++;
            // _load(tags, _savedPage, _perPage);
            setState(() {
              _items.clear();
            });
            Navigator.pop(context, 'Clear');
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Next Page'),
          onPressed: () {
            _savedPage++;
            _load(_savedPage, _perPage);
            Navigator.pop(context, 'Next Page');
          },
        ),*/
        CupertinoActionSheetAction(
          child: const Text('zenn swift'),
          onPressed: () {
            _tag = _tagZennSwift;
            _savedPage = 1;
            _items.clear();
            _scrollController.animateTo(
              0,  // first item
              duration: Duration(seconds: 2),
              curve: Curves.easeOutCirc,
            );
            _load(_savedPage, _perPage);
            Navigator.pop(context, 'zenn swift');
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('hbfav'),
          onPressed: () {
            _tag = _tagHbfav;
            _savedPage = 1;
            _items.clear();
            _scrollController.animateTo(
              0,  // first item
              duration: Duration(seconds: 2),
              curve: Curves.easeOutCirc,
            );
            _load(_savedPage, _perPage);
            Navigator.pop(context, 'hbfav');
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('flutter_my_app2'),
          onPressed: () async {
            if (await canLaunch(
                "https://mbp.hatenablog.com/entry/2022/02/05/143159")) {
              Navigator.pop(context, 'flutter_my_app2');
              await launch(
                  "https://mbp.hatenablog.com/entry/2022/02/05/143159");
            }
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
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

var subTitleTextStyle = TextStyle();
TextStyle _buildSubTitleTextStyle() {
  return subTitleTextStyle = TextStyle(
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.none,
    fontSize: 13,
    color: CupertinoColors.systemYellow,
  );
}

String readTimestamp(int timestamp) {
  var now = new DateTime.now();
  var format = new DateFormat('HH:mm a');
  var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  var diff = date.difference(now);
  var time = '';

  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + 'DAY AGO';
    } else {
      time = diff.inDays.toString() + 'DAYS AGO';
    }
  }

  return time;
}

String fromAtNow(String sentDateJst) {
  DateTime date = DateTime.parse(sentDateJst);

  final Duration difference = DateTime.now().difference(date);
  final int sec = difference.inSeconds;

  if (sec >= 60 * 60 * 24 * 30) {
    double inMonths = sec / 60 / 60 / 24 / 30;
    int intMonths = inMonths.toInt();
    if(intMonths < 2)  return 'a month ago';
    else if(intMonths > 11)  return 'a year ago';
    else return '${intMonths} months ago';
  } else if (sec >= 60 * 60 * 24) {
    return '${difference.inDays.toString()} days ago';
  } else if (sec >= 60 * 60) {
    return '${difference.inHours.toString()} hours ago';
  } else if (sec >= 60) {
    return '${difference.inMinutes.toString()} minutes ago';
  } else {
    return '$sec seconds ago';
  }
}

Future<void> _launchURL(String url) async {
  await launch(url);
}
