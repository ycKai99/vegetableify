import 'package:flutter/material.dart';
import 'package:vegetableify/registrationScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Container(
                //     margin: EdgeInsets.all(40),
                //     child: Image.asset(
                //         'assets/images/5b8f4891e7bce763734073aa.jpg')
                // ),

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

                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minWidth: 150,
                          color: Colors.greenAccent,
                          child: Text('Login',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15)),
                          onPressed: _login,
                        ), //login button
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Text('Register New Account',
                      style: TextStyle(fontSize: 14)),
                  onTap: _regNewUser,
                ),
                SizedBox(height: 5),
                GestureDetector(
                  child:
                      Text('Forgot Password', style: TextStyle(fontSize: 14)),
                  onTap: _forgotPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onChange(bool value) {
    //String _email = _emailController.text.toString();
    //String _password = _passwordController.text.toString();
    setState(() {
      _rememberMe = value;
    });
  }

  void _login() {}

  void _regNewUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
  }

  void _forgotPassword() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //title: Text("Forgot Password"),
            content: new Container(
              height: 80,
              child: Column(
                children: [
                  Text("Reset your password"),
                  TextField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email, size: 18))),
                ],
              ),
            ),
            actions: [
              TextButton(child: Text("Submit"), onPressed: () {}),
              TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
} //end login screen
