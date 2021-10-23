import 'package:flutter/material.dart';
import 'package:password_memo/main.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          /*
          leading: Builder(
            builder:(BuildContext context){
              return IconButton(
                  icon:const Icon(Icons.arrow_back),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp())
                    );
                  },
              );
            }
      )*/
),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'ADD PAGE',
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
