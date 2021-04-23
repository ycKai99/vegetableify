import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'loginScreen.dart';
import 'package:flutter/services.dart';

/* Step for register user
1. enter email and password format

2. click register
- check email and password format
- show confirm showDialog
- call register user method
- register success
*/

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _showPassword = true;
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
              Container(
                  margin: EdgeInsets.fromLTRB(25, 20, 20, 10),
                  child: Image.asset('assets/images/logo.png')),

              SizedBox(height: 5),

              Card(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 20),
                elevation: 8,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                        child: Text('REGISTER', style: TextStyle(fontSize: 23)),
                      ),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email *',
                          hintText: 'Your email address',
                          icon: Icon(Icons.email, size: 20),
                        ),
                      ),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password *',
                          hintText: '8 - 10 character',
                          icon: Icon(Icons.lock, size: 20),
                          suffix: InkWell(
                            onTap: _onClick,
                            child: Icon(Icons.visibility),
                          ),
                        ),
                        obscureText: _showPassword,
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _passwordConfController,
                        decoration: InputDecoration(
                          labelText: 'Enter Password Again *',
                          hintText: '8 - 10 character',
                          icon: Icon(Icons.lock, size: 20),
                          suffix: InkWell(
                            onTap: _onClick,
                            child: Icon(Icons.visibility),
                          ),
                        ),
                        obscureText: _showPassword,
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 80, 0),
                          child: Text(' * Password format',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        onTap: _passwordFormat,
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
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 0, 15),
                    child: Text('Already Have Account ? ',
                        style: TextStyle(fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ]),
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
      showToast(1);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
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
                    _checkEmailPassword(_email, _password, _confPassword);
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
  } //end register

  void _registerUser(String email, String password) {
    http.post(Uri.parse("http://yck99.com/vegetableify/php/register_user.php"),
        body: {"email": email, "password": password}).then((response) {
      print(response.body);
      if (response.body == "success") {
        showToast(2);
      } else {
        showToast(3);
      }
    });
  } //end register

  void _checkEmailPassword(String email, String password, String confPassword) {
    if (email.isEmpty == true ||
        password.isEmpty == true ||
        confPassword.isEmpty == true) {
      showToast(1);
      return;
    } else {
      if (password != confPassword) {
        showToast(4);
        return;
      } else {
        if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                    .hasMatch(email) ==
                true &&
            RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,10}$')
                    .hasMatch(password) ==
                true) {
          showToast(2);
          _registerUser(email, password);
          return;
        } else {
          showToast(0);
        }
      }
    }
  } //end _checkEmailPassword

  void showToast(int num) {
    switch (num) {
      case 1:
        Fluttertoast.showToast(
            msg: "Please enter your email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16);
        break;
      case 2:
        Fluttertoast.showToast(
            msg: "Register Success. Please check your email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16);
        break;
      case 3:
        Fluttertoast.showToast(
            msg: "Cannot register using the same email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16);
        break;
      case 4:
        Fluttertoast.showToast(
            msg: "Please enter the same password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16);
        break;

      default:
        Fluttertoast.showToast(
            msg: "Please enter correct email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16);
    }
  } //end showError

  void _onClick() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _passwordFormat() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text("Password Format "),
            content: new Container(
              height: 100,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        '- Minimum 1 upper case',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '- Minimum 1 lower case',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '- Minimum 1 numeric case',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '- Minimum 1 special case',
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        '- Common allow character',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextButton(
                    child: Text("OK",
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ],
          );
        });
  }
} //end register screen
