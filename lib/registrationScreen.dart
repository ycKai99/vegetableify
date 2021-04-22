import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'loginScreen.dart';

/* Step for register user
1. enter email and password format
2. click rememberMe to save email and password
3. click register
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
  bool _rememberMe = false;
  SharedPreferences sharedPref;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordConfController = new TextEditingController();
  @override
  void initState() {
    loadPreference();
    super.initState();
  }

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
                          hintText: '8 - 10 character',
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
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(68, 0, 0, 0),
                    child: Text('Already Have Account ? ',
                        style: TextStyle(fontSize: 14)),
                  ),
                  Text("Login",
                      style: TextStyle(fontSize: 14, color: Colors.green)),
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
  } //end register

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
        _passwordConfController.text = "";
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
} //end register screen
