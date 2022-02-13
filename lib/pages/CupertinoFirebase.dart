import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'DarkModeColor.dart';
import 'package:flutter/foundation.dart';

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
    /*FirebaseFirestore.instance
                    .collection('users') // コレクションID
                    .doc('id_abc') // ドキュメントID
                    .set({'name': '鈴木', 'age': 40}); // データ*/

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
                      email: "a@a.co.jp",
                      password: "bbbbbb",
                    );*/

                    final schoolRepository = SchoolRepository();
                    final insertSchool = new School(
                      name:"サンプル学校",
                      updatedAt: DateTime.now(),
                      createdAt: DateTime.now()
                    );
                    final documentId = await schoolRepository.insert(insertSchool);
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

/// 学校を扱うリポジトリ
class SchoolRepository {
  final schoolsManager = FirebaseFirestore.instance.collection('schools');
  /// 学校情報を保存する
  Future<String> insert(School school) async {
    final data = await schoolsManager.add(school.toJson());
    return data.id;
  }
}

@immutable
class School {
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  School({
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  //DartのオブジェクトからFirebaseへ渡す際の変換処理
  Map<String, Object?> toJson() {
    Timestamp? deletedTimestamp;
    if (deletedAt != null) {
      deletedTimestamp = Timestamp.fromDate(deletedAt!);
    }
    return {
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt), //DartのDateTimeからFirebaseのTimestampへ変換
      'updatedAt': Timestamp.fromDate(updatedAt), //DartのDateTimeからFirebaseのTimestampへ変換
      'deletedAt': deletedTimestamp
    };
  }
}
