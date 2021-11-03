import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:password_memo/main.dart';
import 'package:password_memo/model/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:password_memo/database.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Modify extends StatelessWidget {
  const Modify(
      {Key? key,
      required this.getId,
      required this.getType,
      required this.getMail,
      required this.getPass})
      : super(key: key);

  final int getId;
  final String getType;
  final String getMail;
  final String getPass;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ぱすめも',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ModifyPage(
        title: 'ぱすめも',
        preID: getId,
        preType: getType,
        preMail: getMail,
        prePass: getPass,
      ),
    );
  }
}

class ModifyPage extends StatefulWidget {
  const ModifyPage({
    Key? key,
    required this.title,
    required this.preID,
    required this.preType,
    required this.preMail,
    required this.prePass,
  }) : super(key: key);

  final String title;
  final int preID;
  final String preType;
  final String preMail;
  final String prePass;

  @override
  State<ModifyPage> createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  String _type = '';
  String _mail = '';
  String _pass = '';

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
  void initState(){
    inputTypeController.text=widget.preType;
    inputMailController.text=widget.preMail;
    inputPassController.text=widget.prePass;
  }

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
                decoration: const InputDecoration(
                    hintText: 'IDやメールアドレス', icon: Icon(Icons.account_circle)),
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                controller: inputMailController,
              ),
              TextField(
                decoration: const InputDecoration(
                    hintText: 'パスワード', icon: Icon(Icons.security)),
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

                    var passModel = PasswordModel(
                        id: widget.preID,
                        type: _type,
                        pass: _pass,
                        mail: _mail);

                    await PasswordModel.updateData(passModel);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyApp()));
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      animType: AnimType.LEFTSLIDE,
                      headerAnimationLoop: true,
                      title: '変更完了',
                      btnOkOnPress: () {
                        debugPrint('OnClcik');
                      },
                      btnOkIcon: Icons.check_circle,
                    ).show();
                  },
                ),
              )
            ],
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
