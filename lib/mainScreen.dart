import 'package:flutter/material.dart';

import 'loginScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
            child: Column(children: [
          MaterialButton(
            child: Text('back'),
            onPressed: _back,
          ),
          FloatingActionButton(
            child: Text('Click'),
            onPressed: _click,
          ),
        ])),
      ),
    );
  }

  void _back() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _click() {}
}
