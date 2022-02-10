import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'CupertinoWebView.dart';

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
     this.id,
     this.likesCount,
     this.createdAt,
     this.url,
   });

   final String? title;
   final String? profileImageUrl;
   final String? id;
   final int? likesCount;
   final String? createdAt;
   final String? url;
 }

class _State extends State<Qiita> {
  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  List<Item> _items = <Item>[];

  //final MyPage page = MyPage.newPage();

  int _sqliteSavedPage = 0;
  int _sqlliteSavedPerPage = 0;

  var _tag = 'flutter';

  final _tagsTrends = 'trends';
  final _tagFlutter = 'flutter';
  final _tagSwift = 'swift';
  int _savedPage = 1;
  int _perPage = 20;
  double _pageMaxScrollExtend = 877.0;  // Simulator iPhone 13, _perPage 20の時
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
        (_scrollController.offset - (_pageMaxScrollExtend * (_savedPage - 1))) / _maxScrollExtend;

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
    //var res;

    //final res = await http.get(Uri.parse('https://qiita.com/api/v2/items'));
    //final res = await http.get(Uri.parse('https://qiita.com/api/v2/tags/Flutter/items?page=1&per_page=20'));
    final res = await http.get(Uri.parse('https://qiita.com/api/v2/tags/' +
          _tag +
          '/items?page=' +
          _page.toString() +
          '&per_page=' +
          _perPage.toString()));
    final data = json.decode(res.body);
    setState(() {
      final items = data as List;
      items.forEach((dynamic element) {
        final issue = element as Map;
        _items.add(Item(
          title: issue['title'] as String,
          profileImageUrl: issue['user']['profile_image_url'] as String,
          id: issue['user']['id'] as String,
          likesCount: issue['likes_count'],
          createdAt: issue['created_at'] as String,
          url: issue['url'] as String,
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

      child: (_items == null || _items.length == 0)?
          Text("Loading....",style: _buildTextStyle(),) :
        ListView.builder(
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
                        await _launchURL(
                          issue.url!);
                      },
                      child: Text(
                        issue.title!,
                        style: _buildTextStyle(),
                      ),
                    ),
                  ),
                  Text(
                    fromAtNow(issue.createdAt!) + ' - ' + issue.id!,
                    style: _buildSubTitleTextStyle(),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        issue.likesCount!.toString() + ' likes',
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

    );
  }

  Widget _buildCupertinoActionSheet() {
    return CupertinoActionSheet(
      //title: const Text('選択した項目が画面に表示されます'),
      actions: <Widget>[
        CupertinoActionSheetAction(
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

var myTextStyle = new TextStyle();
TextStyle _buildTextStyle() {
  return myTextStyle = new TextStyle(
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.none,
    fontSize: 16,
    color: CupertinoColors.white,
  );
}

var subTitleTextStyle = new TextStyle();
TextStyle _buildSubTitleTextStyle() {
  return subTitleTextStyle = new TextStyle(
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
