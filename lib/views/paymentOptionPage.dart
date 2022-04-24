import 'package:flutter/material.dart';
import 'package:happysmacks/views/checkoutPage.dart';
import 'package:happysmacks/views/existingCardsPage.dart';


class PaymentOptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        secondaryHeaderColor: Colors.greenAccent,
      ),
      home: new PaymentOptionItems(),
    );
  }
}

class PaymentOptionItems extends StatefulWidget {
  @override
  _PaymentOptionItems createState() => _PaymentOptionItems();
}

class _PaymentOptionItems extends State<PaymentOptionItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Select Payment'),
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () =>
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckOutPage())),
            )
        ),

        body:
          Center(
            child: ListView(
                children: <Widget>[
                  Container(margin: const EdgeInsets.all(15), alignment: Alignment.centerLeft,
                    child: FlatButton.icon(onPressed: null, icon: Icon(Icons.add_circle, size: 40, color: Colors.green), label: Text('Pay via new card', style: TextStyle(fontSize: 18, color: Colors.green) )),
                  ),
                  Container(margin: const EdgeInsets.all(15), alignment: Alignment.centerLeft,
                    child: FlatButton.icon(
                        onPressed: () => Navigator.push(
                            context, MaterialPageRoute(builder: (context) => ExistingCardsPage())),
                        icon: Icon(Icons.credit_card, size: 40, color: Colors.blue), label: Text('Pay via existing card', style: TextStyle(fontSize: 18, color: Colors.blue))),
                  ),
                ])
          )
    );
    // body:
    // Center(
    //   Container(
    //
    //     padding: EdgeInsets.all(15),
    //     child: ListView(
    //       children: <Widget>[
    //         Container(
    //           margin: const EdgeInsets.all(15),
    //           child: FlatButton.icon(onPressed: null, icon: Icon(Icons.add_circle), label: Text('Pay via new card')),
    //         ),
    //         FlatButton.icon(onPressed: null, icon: Icon(Icons.credit_card), label: Text('Pay via existing card')),
    //       ]
    //     ),
    //   )
    // ),


  }
}
