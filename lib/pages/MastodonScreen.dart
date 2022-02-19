import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'CupertinoWebView.dart';
import 'package:url_launcher/url_launcher.dart';

class Mastodon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class Item {
  Item({
    this.content,
    this.uri,
    this.createdAt,
    this.favourites_count,
    this.id,
  });

  final String? content;
  final String? uri;
  final String? createdAt;
  final int? favourites_count;
  final String? id;
}

class _State extends State<Mastodon> {
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  List<Item> _items = <Item>[];

  //final MyPage page = MyPage.newPage();

  int _sqliteSavedPage = 0;
  int _sqlliteSavedPerPage = 0;

  var _tag = 'drikin';

  final _tagsTrends = 'trends';
  final _tagFlutter = 'flutter';
  final _tagReact   = 'react';
  final _tagSwift   = 'swift';
  int _savedPage = 1;
  int _perPage = 20;
  var _maxId = "999999999999999999";
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
    final res = await http.get(Uri.parse('https://mstdn.guru/api/v1/accounts/1/statuses?max_id=' +
        _maxId));
    final data = json.decode(res.body);
    setState(() {
      final items = data as List;
      items.forEach((dynamic element) {
        final issue = element as Map;
        String resultConent = issue['content'].replaceAll('<p>','');
        resultConent = resultConent.replaceAll('</p>','');
        resultConent = resultConent.replaceAll('<span>','');
        resultConent = resultConent.replaceAll('</span>','');
        resultConent = resultConent.replaceAll('%lt','');
        resultConent = resultConent.replaceAll('<br />','');
        resultConent = resultConent.replaceAll('<span class="h-card">','');
        resultConent = resultConent.replaceAll('<a href="https://mstdn.guru/','');
        resultConent = resultConent.replaceAll('" class="u-url mention">','');
        resultConent = resultConent.replaceAll('</a>','');
        resultConent = resultConent.replaceAll('&amp;','&');
        resultConent = resultConent.replaceAll('<a href=jhttps://qiitadon.com/','');
        resultConent = resultConent.replaceAll('&gt','>');
        resultConent = resultConent.replaceAll('" class="mention hashtag" rel="tag">','');
        resultConent = resultConent.replaceAll('tags/','#');
        resultConent = resultConent.replaceAll('&quot;','"');
        _items.add(Item(
          content: resultConent,
          //profileImageUrl: issue['user']['profile_image_url'] as String,
          //id: issue['user']['id'] as String,
          id: issue['id'] as String,
          favourites_count: issue['favourites_count'],
          createdAt: issue['created_at'] as String,
          uri: issue['uri'] as String,
          // tags: issue['tags'] as List,
        ));
      });
      _maxId = _items[_items.length-1].id as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.black,
          middle: Text(
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
                              //issue.profileImageUrl!,
                              'https://mstdn.guru/system/accounts/avatars/000/000/001/original/b9be170352507d233d043df178a9a384.png',
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
                                    await _launchURL(issue.uri!);
                                  },
                                  child: Text(
                                    issue.content!,
                                    style: _buildTextStyle(),
                                  ),
                                ),
                              ),
                              Text(
                                fromAtNow(issue.createdAt!),// + ' - ' + issue.id!,
                                style: _buildSubTitleTextStyle(),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    issue.favourites_count!.toString() + ' favs',
                                    style: _buildSubTitleTextStyle(),
                                  ),
                                ],
                              ),
                              // Text(
                              //   // issue.tags.length == 1 ? issue.tags[0][0] : "",
                              //   issue.tags.name,
                              // ),
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
          child: const Text('tag swift'),
          onPressed: () {
            _tag = _tagSwift;
            _savedPage = 1;
            _items.clear();
            _scrollController.animateTo(
              0,  // first item
              duration: Duration(seconds: 2),
              curve: Curves.easeOutCirc,
            );
            _load(_savedPage, _perPage);
            Navigator.pop(context, 'tag swift');
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('tag react'),
          onPressed: () {
            _tag = _tagReact;
            _savedPage = 1;
            _items.clear();
            _scrollController.animateTo(
              0,  // first item
              duration: Duration(seconds: 2),
              curve: Curves.easeOutCirc,
            );
            _load(_savedPage, _perPage);
            Navigator.pop(context, 'tag react');
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('tag flutter'),
          onPressed: () {
            _tag = _tagFlutter;
            _savedPage = 1;
            _items.clear();
            _scrollController.animateTo(
              0,  // first item
              duration: Duration(seconds: 2),
              curve: Curves.easeOutCirc,
            );
            _load(_savedPage, _perPage);
            Navigator.pop(context, 'tag flutter');
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

String fromAtNow(String sentDateJst) {
  DateTime date = DateTime.parse(sentDateJst);

  final Duration difference = DateTime.now().difference(date);
  final int sec = difference.inSeconds;

  if (sec >= 60 * 60 * 24) {
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
