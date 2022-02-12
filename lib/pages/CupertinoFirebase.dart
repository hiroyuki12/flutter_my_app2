import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'DarkModeColor.dart';

class CupertinoFirebase extends StatefulWidget {
  @override
    State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<CupertinoFirebase> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //DatabaseReference ref = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    //ref.child("Name2").set("Hello3");
    FirebaseFirestore.instance
                    .collection('users') // コレクションID
                    .doc('id_abc') // ドキュメントID
                    .set({'name': '鈴木', 'age': 40}); // データ

    isDarkMode = true;  // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor: isDarkMode ? darkModeBackColor : backColor,  //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor: isDarkMode ? darkModeBackColor : backColor,  //white , darkMode=black
        middle: Text("Cupertino Firebase", style: _buildTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: 
            CupertinoButton(
              //color: CupertinoColors.activeBlue,
              //borderRadius: new BorderRadius.circular(30.0),
              onPressed: () async {
                    /*final UserCredential result =                
                        await auth.createUserWithEmailAndPassword(     
                      email: "a@a",                              
                      password: "bb",                            
                    );*/      
              },
              child: Text('Cupertino Firebase', style: _buildTextStyle()),
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
  color: isDarkMode ? darkModeForeColor : foreColor,  //black , darkMode=white
  );
}
