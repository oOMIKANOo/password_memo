import 'package:flutter/material.dart';
import 'package:password_memo/main.dart';
import 'package:path/path.dart';

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
  String _id = '';
  String _pass = '';

  // 入力された内容を保持するコントローラ
  final inputTypeController = TextEditingController();
  final inputIdController = TextEditingController();
  final inputPassController = TextEditingController();

  void _handleType(String e) {
    setState(() {
      _type = e;
    });
  }

  void _handleId(String e) {
    setState(() {
      _id = e;
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
                controller: inputIdController,
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
                  onPressed: () {
                    _handleType(inputTypeController.text);
                    _handleId(inputIdController.text);
                    _handlePass(inputPassController.text);
                  },
                ),
              )
            ],
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
