import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'CupertinoWebView.dart';
import 'DarkModeColor.dart';

class CupertinoFlutterIssues extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CupertinoFlutterIssues> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (_type == 0)
      _url = 'https://api.github.com/repositories/31792824/issues';
    else
      _url = 'https://api.github.com/repositories/31792824/commits';
    final res = await http.get(Uri.parse(_url));
    final data = json.decode(res.body);
    setState(() {
      _buildIssuesCommits(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        middle: Text(_navigationBarTitle, style: _buildTextStyle()),
        trailing: _buildTrailingButton(),
        // backgroundColor: const Color(0xff333333),
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      ),
      child: (_issues == null || _issues.length == 0)
          ? Text(
              "Loading....",
              style: _buildTextStyle(),
            )
          : _buildListView(context),
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (_type == 0) {
          //if (index >= _issues.length) {
          //  return null;
          //}

          final issue = _issues[index];
          return _buildIssuesRow(issue);
        } else {
          //if (index >= _commits.length) {
          //  return null;
          //}

          final commit = _commits[index];
          String message = commit.message!;
          int maxLength = 80;
          if (message.length > maxLength) {
            message = commit.message!.substring(0, maxLength);
          }
          return _buildCommitRow(commit, message);
        }
      },
    );
  }

  Widget _buildTrailingButton() {
    return FlatButton(
      child: Text(_buttonTitle, style: _myTextStyle),
      onPressed: () {
        setState(() {
          if (_type == 0) {
            _navigationBarTitle = 'Flutter Commits';
            _buttonTitle = 'Issues';
            _type = 1;
          } else {
            _navigationBarTitle = 'Flutter Issues';
            _buttonTitle = 'Commits';
            _type = 0;
          }
          _load();
        });
      },
    );
  }

  Widget _buildIssuesRow(Issue issue) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          // padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: ClipOval(
            child: Image.network(
              issue.avatarUrl!,
              width: 50,
            ),
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
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => MyCupertinoWebView(
                        url: issue.htmlUrl,
                      ),
                    ),
                  );
                },
                child: Text(
                  issue.title!,
                  style: _myTextStyle,
                ),
              ),
            ),
            Text(
              '#' + issue.number! + '  opened  ' + issue.updatedAt!,
              style: _mySubTitleTextStyle,
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildCommitRow(Commit commit, String message) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          // padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: ClipOval(
            child: Image.network(
              commit.avatarUrl!,
              width: 50,
            ),
          ),
        ),
        Expanded(
            child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                  //for InkWell
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => MyCupertinoWebView(
                            url: commit.htmlUrl,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      commit.message!,
                      style: _myTextStyle,
                    ),
                  ),
                ),
                Text(
                  commit.login! + ' committed  ' + commit.date!,
                  style: _mySubTitleTextStyle,
                ),
              ],
            ),
          ],
        )),
      ],
    );
  }
}

void _buildIssuesCommits(final data) {
  if (_type == 0) {
    final issues = data as List;
    issues.forEach((dynamic element) {
      final issue = element as Map;
      _issues.add(Issue(
        title: issue['title'] as String,
        htmlUrl: issue['html_url'] as String,
        avatarUrl: issue['user']['avatar_url'] as String,
        // number: issue['number'].toString() as String,
        number: issue['number'].toString(),
        updatedAt: issue['updated_at'] as String,
      ));
    });
  } else {
    final commits = data as List;
    commits.forEach((dynamic element) {
      final commit = element as Map;
      _commits.add(Commit(
        message: commit['commit']['message'] as String,
        htmlUrl: commit['html_url'] as String,
        avatarUrl: commit['author']['avatar_url'] as String,
        sha: commit['sha'] as String,
        date: commit['commit']['committer']['date'] as String,
        login: commit['author']['login'] as String,
      ));
    });
  }
}

String _navigationBarTitle = 'Flutter Issues';
String _buttonTitle = 'Commits';

String _url = '';

class Issue {
  Issue({
    this.title,
    this.htmlUrl,
    this.avatarUrl,
    this.number,
    this.updatedAt,
  });

  final String? title;
  final String? htmlUrl;
  final String? avatarUrl;
  final String? number;
  final String? updatedAt;
}

class Commit {
  Commit({
    this.message,
    this.htmlUrl,
    this.avatarUrl,
    this.sha,
    this.date,
    this.login,
  });

  final String? message;
  final String? htmlUrl;
  final String? avatarUrl;
  final String? sha;
  final String? date;
  final String? login;
}

var _myTextStyle = TextStyle();
TextStyle _buildTextStyle() {
  return _myTextStyle = TextStyle(
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.none,
    fontSize: 16,
    // color: CupertinoColors.white
    color: isDarkMode ? darkModeForeColor : foreColor, //black , darkMode=white
  );
}

var _mySubTitleTextStyle = TextStyle(
  fontWeight: FontWeight.w100,
  decoration: TextDecoration.none,
  fontSize: 13,
  // color: CupertinoColors.systemBlue,
  color: CupertinoColors.systemYellow,
);

// 0:Flutter Issues
// 1:Flutter Commits
int _type = 0;

List<Issue> _issues = <Issue>[];
List<Commit> _commits = <Commit>[];
