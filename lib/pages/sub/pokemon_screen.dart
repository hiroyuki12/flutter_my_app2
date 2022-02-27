import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Pokemon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class Item {
  Item({
    this.id,
    this.name,
    this.types,
    this.imageUrl,
  });

  final int? id;
  final String? name;
  final List<String>? types;
  final String? imageUrl;

  factory Item.fromJson(Map<String, dynamic> json) {
    List<String> typesToList(dynamic types) {
      List<String> ret = [];
      for (int i = 0; i < types.length; i++) {
        ret.add(types[i]['type']['name']);
      }
      return ret;
    }

    return Item(
      id: json['id'],
      name: json['name'],
      types: typesToList(json['types']),
      imageUrl: json['sprites']['other']['official-artwork']['front_default'],
    );
  }
}

class _State extends State<Pokemon> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  final List<Item> _items = <Item>[];

  //final MyPage page = MyPage.newPage();

  //final int _sqliteSavedPage = 0;
  //final int _sqlliteSavedPerPage = 0;

  final int _savedPage = 1;
  final int _perPage = 20;
  final double _pageMaxScrollExtend = 877.0; // Simulator iPhone 13, _perPage 20の時
  final double _maxScrollExtend = 877.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    for(int i=1; i<21; i++) {
      _items.add(Item());
    }
    for(int i=1; i<21; i++) {
      _load(i);
    }
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
        //_savedPage++;
        //_load(_savedPage, _perPage);
        //print('_load');
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
  Future<void> _load(int id) async {
    final res = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
    setState(() {
      Item i = Item.fromJson(jsonDecode(res.body));
      _items[i.id!-1] = Item.fromJson(jsonDecode(res.body));
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: CupertinoColors.black,
          middle: Text(
              // "CupertinoQiita Page " +
              'pockemon' +
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
            child: const Text('menu'),
          ),
        ),
        child: (_items.isEmpty)
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
                              issue.imageUrl!,
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
                                    //await _launchURL(issue.url!);
                                  },
                                  child: Text(
                                    issue.name! + ' (' + issue.id.toString() + ')',
                                    style: _buildTextStyle(),
                                  ),
                                ),
                              ),
                              /*Text(
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
                              ),*/
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
          child: const Text('Next Page'),
          onPressed: () {
            _savedPage++;
            _load(_savedPage, _perPage);
            Navigator.pop(context, 'Next Page');
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
              duration: const Duration(seconds: 2),
              curve: Curves.easeOutCirc,
            );
            _load(_savedPage, _perPage);
            Navigator.pop(context, 'tag flutter');
          },
        ),*/
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

var myTextStyle = const TextStyle();
TextStyle _buildTextStyle() {
  return myTextStyle = const TextStyle(
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.none,
    fontSize: 16,
    color: CupertinoColors.white,
  );
}

var subTitleTextStyle = const TextStyle();
TextStyle _buildSubTitleTextStyle() {
  return subTitleTextStyle = const TextStyle(
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.none,
    fontSize: 13,
    color: CupertinoColors.systemYellow,
  );
}


Future<void> _launchURL(String url) async {
  await launch(url);
}
