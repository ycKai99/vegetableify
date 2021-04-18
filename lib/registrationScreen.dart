import 'package:flutter/material.dart';

import 'loginScreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _rememberMe = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              // Container(
              //     margin: EdgeInsets.all(40),
              //     child: Image.asset(
              //         'assets/images/5b8f4891e7bce763734073aa.jpg')),

              SizedBox(height: 5),

              Card(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 20),
                elevation: 8,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Please enter valid email',
                          icon: Icon(Icons.email, size: 20),
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: '6 - 8 character',
                          icon: Icon(Icons.lock, size: 20),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter Password Again',
                          hintText: '6 - 8 character',
                          icon: Icon(Icons.lock, size: 20),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                              value: _rememberMe,
                              onChanged: (bool value) {
                                _onChange(value);
                              }),
                          Text("Remember me")
                        ],
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        minWidth: 150,
                        color: Colors.greenAccent,
                        child: Text('Register',
                            style:
                                TextStyle(color: Colors.black, fontSize: 15)),
                        onPressed: _register,
                      ), //register button
                    ],
                  ),
                ),
              ), //register card
              GestureDetector(
                child: Text('Already Have Account',
                    style: TextStyle(fontSize: 16)),
                onTap: _alreadyReg,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _alreadyReg() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _register() {}

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }
}
