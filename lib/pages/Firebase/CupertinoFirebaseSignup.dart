import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../DarkModeColor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CupertinoFirebaseSignup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CupertinoFirebaseSignup> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String _text = '';

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        navigationBar: CupertinoNavigationBar(
          backgroundColor: isDarkMode
              ? darkModeBackColor
              : backColor, //white , darkMode=black
          middle: Text("Cupertino Firebase Signup", style: _buildTextStyle()),
          //trailing: Text("Edit", style: myTextStyle),
        ),
        child: Column(
          children: <Widget>[
            Text('Email', style: _buildTextStyle()),
            CupertinoTextField(
              decoration: BoxDecoration(
                color: Colors.blue[100],
              ),
            ),
            Text('Password', style: _buildTextStyle()),
            CupertinoTextField(
              decoration: BoxDecoration(
                color: Colors.blue[100],
              ),
              obscureText: true,
            ),
            CupertinoButton(
              //color: CupertinoColors.activeBlue,
              //borderRadius: new BorderRadius.circular(30.0),
              onPressed: () async {
                final UserCredential result =
                    await auth.createUserWithEmailAndPassword(
                  email: "a@a.co.jp",
                  password: "bbbbbb",
                );

                /*try {
                  final UserCredential result =
                      await auth.signInWithEmailAndPassword(
                    email: "a@a.co.jp",
                    password: "bbbbbb",
                  );
                  // ログインに成功した場合
                  final User user = result.user!;
                  print("ログインOK:${user.email}");
                } catch (e) {
                  print("ログインNG：${e.toString()}");
                }*/
              },
              child: Text('Sign Up', style: _buildTextStyle()),
            ),
          ],
        ));
  }
}

var myTextStyle = TextStyle();
TextStyle _buildTextStyle() {
  return myTextStyle = TextStyle(
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.none,
    fontSize: 16,
    color: isDarkMode ? darkModeForeColor : foreColor, //black , darkMode=white
  );
}
