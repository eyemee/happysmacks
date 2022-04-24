import 'package:flutter/material.dart';
import '../services/userService.dart';
import 'dart:convert';
import '../main.dart';

class ForgotPasswordPage extends StatelessWidget {
  final fldCodeController = TextEditingController();
  final fldPwordController = TextEditingController();
  final fldConfirmPwordController = TextEditingController();
  String email = "";

  ForgotPasswordPage(String username) {
    email = username;
  }

  void changePassword(BuildContext context) async {
    String credentials = fldConfirmPwordController.text;
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);

    UserService us = new UserService();
    var decoded = jsonDecode(
        await us.postChangePassword(email, encoded, fldCodeController.text));

    if (decoded['affectedRows'] == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Forgot Password Page'),
        elevation: 1.0,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
          children: <Widget>[
            Container(
              height: 65,
              padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: TextFormField(
                initialValue: null,
                controller: fldCodeController,
                decoration: new InputDecoration(
                  labelText: '4 Digit Code',
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
                  labelText: 'New Password',
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
                controller: fldConfirmPwordController,
                obscureText: true,
                decoration: new InputDecoration(
                  labelText: 'Confirm Password',
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () {
          changePassword(context);
        },
        label: Text('Submit'),
        icon: Icon(Icons.add_circle),
      ),
    );
  }
}
