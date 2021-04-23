import 'package:flutter/material.dart';

import 'loginScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _passwordController = new TextEditingController();
  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    child: Text('back'),
                    onPressed: _back,
                  ),
                  //         Padding(
                  //           padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  //           child: Column(
                  //             children: [
                  //               TextField(
                  //                 controller: _passwordController,
                  //                 decoration: InputDecoration(
                  //                   labelText: 'Password',
                  //                   hintText: '8 - 10 character',
                  //                   icon: Icon(Icons.lock, size: 20),
                  //                   suffix: InkWell(
                  //                     onTap: _onClick,
                  //                     child: Icon(Icons.visibility),
                  //                   ),
                  //                 ),
                  //                 obscureText: _showPassword,
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                ]),
          ),
        ),
      ),
    );
  }

  void _back() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  // void _onClick() {
  //   setState(() {
  //     _showPassword = !_showPassword;
  //   });
  // }
} //end mainScreen
