import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../DarkModeColor.dart';
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

    isDarkMode = true; // switch darkMode
    return CupertinoPageScaffold(
      backgroundColor:
          isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            isDarkMode ? darkModeBackColor : backColor, //white , darkMode=black
        middle: Text("Cupertino Firebase", style: _buildTextStyle()),
        //trailing: Text("Edit", style: myTextStyle),
      ),
      child: CupertinoButton(
        //color: CupertinoColors.activeBlue,
        //borderRadius: new BorderRadius.circular(30.0),
        onPressed: () async {
          /*final UserCredential result =
              await auth.createUserWithEmailAndPassword(
            email: "a@a.co.jp",
            password: "bbbbbb",
          );*/

          try {
            final UserCredential result = await auth.signInWithEmailAndPassword(
              email: "a@a.co.jp",
              password: "bbbbbb",
            );
            // ログインに成功した場合
            final User user = result.user!;
            print("ログインOK:${user.email}");
          } catch (e) {
            print("ログインNG：${e.toString()}");
          }

          /*final schoolRepository = SchoolRepository();
          final insertSchool = School(
              name: "サンプル学校",
              updatedAt: DateTime.now(),
              createdAt: DateTime.now());
          final documentId = await schoolRepository.insert(insertSchool);

          final schoolRepository = SchoolRepository();
          final schools = await schoolRepository.getSchools();
          for (var school in schools) {
            print("ドキュメントID:" + school.id.toString());
            print("学校名:" + school.data().name);
            print("作成日時:" + school.data().createdAt.toString());
          }*/
        },
        child: Text('Cupertino Firebase', style: _buildTextStyle()),
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
    color: isDarkMode ? darkModeForeColor : foreColor, //black , darkMode=white
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

  /// 学校情報を取得する
  Future<List<QueryDocumentSnapshot<School>>> getSchools() async {
    final schoolRef = schoolsManager.withConverter<School>(
        fromFirestore: (snapshot, _) => School.fromJson(snapshot.data()!),
        toFirestore: (school, _) => school.toJson());
    final schoolSnapshot = await schoolRef.get();
    return schoolSnapshot.docs;
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
      'createdAt':
          Timestamp.fromDate(createdAt), //DartのDateTimeからFirebaseのTimestampへ変換
      'updatedAt':
          Timestamp.fromDate(updatedAt), //DartのDateTimeからFirebaseのTimestampへ変換
      'deletedAt': deletedTimestamp
    };
  }

  //Firebaseからデータを取得する際の変換処理
  School.fromJson(Map<String, Object?> json)
      : this(
            name: json['name']! as String,
            createdAt: (json['createdAt']! as Timestamp).toDate() as DateTime,
            updatedAt: (json['updatedAt']! as Timestamp).toDate() as DateTime,
            deletedAt:
                (json['deletedAt'] as Timestamp?)?.toDate() as DateTime?);
}
