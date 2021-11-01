import 'package:flutter/material.dart';
import 'package:password_memo/main.dart';
import 'package:password_memo/model/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:password_memo/database.dart';
import 'package:intl/intl.dart';

class Add extends StatelessWidget {
  const Add({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ぱすめも',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AddPage(title: 'ぱすめも'),
    );
  }
}

class AddPage extends StatefulWidget {
  const AddPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String _type = '';
  String _mail = '';
  String _pass = '';
  int _id = 0;

  // 入力された内容を保持するコントローラ
  final inputTypeController = TextEditingController();
  final inputMailController = TextEditingController();
  final inputPassController = TextEditingController();

  void _handleType(String e) {
    setState(() {
      _type = e;
    });
  }

  void _handleId(String e) {
    setState(() {
      _mail = e;
    });
  }

  void _handlePass(String e) {
    setState(() {
      _pass = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MyApp()));
                },
              );
            })),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(hintText: '(例)Google'),
                autofocus: true,
                maxLines: 1,
                controller: inputTypeController,
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'IDやメールアドレス'),
                maxLines: 1,
                controller: inputMailController,
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'パスワード'),
                obscureText: true,
                maxLines: 1,
                controller: inputPassController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () async {
                    _handleType(inputTypeController.text);
                    _handleId(inputMailController.text);
                    _handlePass(inputPassController.text);

                    //日付所得（2020-10-30-1854）
                    DateTime now = DateTime.now();
                    DateFormat outputFormat = DateFormat('yyyyMMddHm');
                    String date = outputFormat.format(now);

                    _id = int.parse(date);

                    var passmodel = PasswordModel(
                        id: _id, type: _type, pass: _pass, mail: _mail);


                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyApp()));
                  },
                ),
              )
            ],
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
