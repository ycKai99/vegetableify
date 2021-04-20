import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegetableify/registrationScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  SharedPreferences sharedPref;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    loadPreference();
    super.initState();
  }

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
                          highlightElevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
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
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    if (_email.isEmpty || _password.isEmpty) {
      showToast(1);
      return;
    }
    setState(() {
      _rememberMe = value;
      savePreference(value, _email, _password);
    });
  } //end onChange

  Future<void> savePreference(bool value, String email, String password) async {
    sharedPref = await SharedPreferences.getInstance();
    if (value) {
      await sharedPref.setString("email", email);
      await sharedPref.setString("password", password);
      await sharedPref.setBool("rememberMe", value);
      Fluttertoast.showToast(
        msg: "Your email and password is saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 15,
      );
      return;
    } else {
      await sharedPref.setString("email", '');
      await sharedPref.setString("password", '');
      await sharedPref.setBool("rememberMe", value);
      Fluttertoast.showToast(
        msg: "Preference removed",
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 15,
      );
      setState(() {
        _emailController.text = "";
        _passwordController.text = "";
        _rememberMe = false;
      });
      return;
    }
  } //end savePreference

  Future<void> loadPreference() async {
    sharedPref = await SharedPreferences.getInstance();
    String _email = sharedPref.getString("email") ?? '';
    String _password = sharedPref.getString("password") ?? '';
    _rememberMe = sharedPref.getBool("rememberMe") ?? false;

    setState(() {
      _emailController.text = _email;
      _passwordController.text = _password;
    });
  } //end loadPreference

  void _regNewUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
  } //end regNewUser

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
                  Text("Reset your password ?"),
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
        }); //end showDialog
  } //end forgotPassword

  void _login() {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    _checkEmailPassword(_email, _password);
  } //end login

  void _checkEmailPassword(String email, String password) {
    if (RegExp("\\w{1,}@\\w{2,10}(\\.\\w{2,10}){1,2}").hasMatch(email) ==
            true &&
        RegExp("").hasMatch(password) == true) {
      showToast(2);
      return;
    } else {
      showToast(0);
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
            msg: "Login Success",
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
} //end login screen
