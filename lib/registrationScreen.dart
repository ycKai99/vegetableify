import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'loginScreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _rememberMe = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordConfController = new TextEditingController();

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
                        controller: _passwordConfController,
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
                            borderRadius: BorderRadius.circular(15)),
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

  void _register() {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    String _confPassword = _passwordConfController.text.toString();
    if (_email.isEmpty || _password.isEmpty || _confPassword.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please enter your email and password",
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 15,
      );
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            title: Text("Register "),
            content: new Container(
              height: 40,
              child: Text("Are you sure you want to register?"),
            ),
            actions: [
              TextButton(
                  child: Text("Confirm",
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _registerUser(_email, _password);
                  }),
              TextButton(
                  child: Text("Cancel",
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }

  void _registerUser(String email, String password) {
    http.post(Uri.parse("http://yck99.com/vegetableify/php/register_user.php"),
        body: {"email": email, "password": password}).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Registration Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16);
      } else {
        Fluttertoast.showToast(
            msg: "Cannot register using the same email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16);
      }
    });
  } //end register
} //end register
