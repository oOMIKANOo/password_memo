import 'package:flutter/material.dart';
import 'package:password_memo/add.dart';
import 'package:password_memo/database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:password_memo/model/model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:password_memo/modify.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
                  return Slidable(
                    actionPane: SlidableStrechActionPane(),
                    actionExtentRatio: 0.2,
                    actions: [
                      IconSlideAction(
                        caption: '編集',
                        color: Colors.lightGreen,
                        icon: Icons.border_color,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Modify(
                                      getId: _list[index].id,
                                      getType: _list[index].type,
                                      getMail: _list[index].mail,
                                      getPass: _list[index].pass,
                                    )),
                          );
                        },
                      ),
                    ],
                    secondaryActions: [
                      IconSlideAction(
                        caption: '削除',
                        color: Colors.red,
                        icon: Icons.remove,
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            animType: AnimType.LEFTSLIDE,
                            headerAnimationLoop: true,
                            title: '注意',
                            desc: 'このデータを削除してもよろしいですか？',
                            btnOkOnPress: () async {
                              debugPrint('OnClcik');
                              //DBから削除処理
                              await PasswordModel.deleteData(_list[index].id);
                              //画面再描画
                              setState(() {});
                            },
                            btnOkIcon: Icons.check_circle,
                            btnCancelOnPress: () {
                              //画面再描画
                              setState(() {});
                            },
                            btnCancelIcon: Icons.cancel,
                          ).show();
                        },
                      ),
                    ],
                    child: ListTile(
                      title: Text(_list[index].type),
                      subtitle: Text(
                          'ID:${_list[index].mail}   パスワード:${_list[index].pass}'),
                    ),
                  );
                },
              );
            },
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
