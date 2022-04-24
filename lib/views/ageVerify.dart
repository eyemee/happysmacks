import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:happysmacks/models/userage.dart';
import 'package:happysmacks/services/cartService.dart';
import 'package:intl/intl.dart';
import 'package:age/age.dart';

import 'itemsPage.dart';

class AgeVerify extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        secondaryHeaderColor: Colors.greenAccent,
      ),
      home: new WidgetAgeVerifyPage(),
    );
  }
}

class WidgetAgeVerifyPage extends StatefulWidget {
  @override
  _WidgetAgeVerifyPage createState() => _WidgetAgeVerifyPage();
}

class _WidgetAgeVerifyPage extends State<WidgetAgeVerifyPage> {
  String dateText = '';
  AgeDuration age;

  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Happysmacks'),
          content: Text("Minors are not allowed to use this app"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Close",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Happysmacks Age Verification'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
                  child: Text('This app may contain content of an adult nature. You are not allowed to proceed if you are under the age of 18. The posts and pages within are intended for adults only and may include scenes of sexual content, suggestive pictures, or graphic violence. You are required to select your birth date before you can proceed.',
                    style: TextStyle(color: Colors.red, fontSize: 18 ),
                    textAlign: TextAlign.justify,
                  ),
                ),

                Container(
                  child: Text(this.dateText),
                ),

                Container(
                  width: 250,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: FlatButton(
                      color: Colors.green,
                      onPressed: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1901, 1, 1),
                            maxTime: DateTime.now(),
                            theme: DatePickerTheme(
                                headerColor: Colors.orange,
                                backgroundColor: Colors.blue,
                                itemStyle: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                            onChanged: (date) {
                            }, onConfirm: (date) async {
                              setState(() {
                                this.dateText = DateFormat('yyyy-MM-dd').format(date);
                                this.age = Age.dateDifference(fromDate: date, toDate: DateTime.now(), includeToDate: false);
                              });

                              if(this.age.years >= 18) {
                                CartService cartService = CartService();
                                await cartService.createDatabase();
                                await cartService.createAge(Userage(age: this.age.years, bdate: date.toString()));
                              }

                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                      },
                      child: Text(
                        'Select Birth Date',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ),
                Container(
                  width: 250,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: FlatButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      if(this.age.years >= 18) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ItemsPage()));
                      } else {
                        showAlert(context);
                      }
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ]),
        )
    );
  }
}
