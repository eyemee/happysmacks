import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'views/registrationPage.dart';
import 'views/forgotPasswordPage.dart';
import 'views/itemsPage.dart';
import 'views/ageVerify.dart';
import 'dart:convert';
import 'package:email_validator/email_validator.dart';

import 'services/userService.dart';

void main() {
  try {
    runApp(MaterialApp(
      title: 'Happysmacks',
      initialRoute: '/',
      routes: {
        '/': (context) => ItemsPage(),
        // '/second': (context) => SecondScreen(),
      },
    ));
  } catch(ex) {
    print(ex.toString());
  }
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      theme: ThemeData(
        primarySwatch: Colors.red,
        secondaryHeaderColor: Colors.redAccent,
      ),
      home: MyHomePage(title: 'happysmacks.com'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final fldNameController = TextEditingController();
  final fldPwordController = TextEditingController();

  void goToRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegistrationPage()));
  }

  void showForgotPasswordAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Forgot Password'),
          content: Text("Are You Sure Want To Change Password? A 4 digit code will be sent to your registered email."),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                submitChangePassword();
                //Put your code here which you want to execute on Yes button click.
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                //Put your code here which you want to execute on Cancel button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void submitChangePassword() async {
    String email = fldNameController.text;
    UserService us = UserService();
    var decoded =
    jsonDecode(await us.postEmail(email));

    if (await decoded['affectedRows'] == 1) {
      print(decoded['affectedRows'] == 1);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage(fldNameController.text)));
    }
  }

  void login() async {
    String credentials = fldPwordController.text;
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);

    // UserService us = new UserService();
    // var decoded =
    //     jsonDecode(await us.postLogin(fldNameController.text, encoded));

    // if (hasInvalidInputs()) {
    //   return;
    // }

    // if (await decoded['authorized']) {
      fldNameController.clear();
      fldPwordController.clear();


      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemsPage()));
          // MaterialPageRoute(
          //     builder: (context) => SimpleBarChart.withSampleData()));
    // } else {
    //   print('Wrong username/password!!!');
    // }
  }

  bool hasInvalidInputs() {
    bool hasInvalidInputs = true;

    if (fldNameController.text == '') {
      print('Username required!!!');
    } else if (fldPwordController.text == '') {
      print('Password required!!!');
    } else {
      hasInvalidInputs = false;
    }

    return hasInvalidInputs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 65,
              padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: TextFormField(
                initialValue: null,
                controller: fldNameController,
                decoration: new InputDecoration(
                  labelText: 'Username',
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 65,
              padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: TextFormField(
                initialValue: null,
                controller: fldPwordController,
                obscureText: true,
                decoration: new InputDecoration(
                  labelText: 'Password',
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if(EmailValidator.validate(fldNameController.text)) {
                  showForgotPasswordAlert(context);
                }
              },
              child: Container(
                height: 35,
                padding: EdgeInsets.fromLTRB(15, 8, 15, 4),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                goToRegister();
              },
              child: Container(
                height: 45,
                padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: Text(
                  "Signup/Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          login();
        },
        tooltip: 'Increment',
        label: Text('Login'),
        icon: Icon(Icons.account_circle),
      ),
    );
  }
}
