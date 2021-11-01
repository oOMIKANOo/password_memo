import 'package:flutter/material.dart';
import 'package:password_memo/add.dart';
import 'package:password_memo/database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:password_memo/model/model.dart';

void main() async {
  runApp(const MyApp());

  //DBの接続処理
  final database = openDatabase(
    join(await getDatabasesPath(), 'database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE pass(id INTEGER PRIMARY KEY, type TEXT, pass TEXT,mail TEXT)",
      );
    },
    version: 1,
  );

  //DBのデータ取得
  Future<List<PasswordModel>> getData() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('pass');
    return List.generate(maps.length, (i) {
      return PasswordModel(
          id: maps[i]['id'],
          type: maps[i]['type'],
          pass: maps[i]['pass'],
          mail: maps[i]['mail']);
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ぱすめも',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'ぱすめも'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //パスワードリスト保存変数
  List<PasswordModel> _list = [];

  //ページ初期化
  Future<void> initialize() async {
    _list = await PasswordModel.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Add()),
                );
              },
            )
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: initialize(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // 非同期処理未完了 = 通信中
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: ListTile(
                        title: Text(_list[index].type),
                        subtitle: Text(_list[index].mail),
                  ));
                },
              );
            },
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
