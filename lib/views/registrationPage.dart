import 'package:flutter/material.dart';
import '../services/userService.dart';
import 'dart:convert';
import '../main.dart';

class RegistrationPage extends StatelessWidget {
  final fldUsernameController = TextEditingController();
  final fldFirstnameController = TextEditingController();
  final fldMiddlenameController = TextEditingController();
  final fldLastnameController = TextEditingController();
  final fldPwordController = TextEditingController();
  final fldConfirmPwordController = TextEditingController();

  void register(BuildContext context) async {
    String credentials = fldConfirmPwordController.text;
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);


    UserService us = new UserService();
    var decoded =
    jsonDecode(await us.postRegister(fldUsernameController.text, encoded, fldFirstnameController.text, fldMiddlenameController.text, fldLastnameController.text ));

    if(decoded['affectedRows'] == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup/Registration Page'),
        elevation: 1.0,
      ),
      body:  Center(
        child: ListView(
          padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
          children: <Widget>[
            Container(
              height: 65,
              padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: TextFormField(
                initialValue: null,
                controller: fldUsernameController,
                decoration: new InputDecoration(
                  labelText: 'Email',
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
                controller: fldFirstnameController,
                decoration: new InputDecoration(
                  labelText: 'First Name',
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
                controller: fldMiddlenameController,
                decoration: new InputDecoration(
                  labelText: 'Middle Name',
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
                controller: fldLastnameController,
                decoration: new InputDecoration(
                  labelText: 'Last Name',
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
          register(context);
        },
        label: Text('Signup'),
        icon: Icon(Icons.add_circle),
      ),
    );
  }
}


