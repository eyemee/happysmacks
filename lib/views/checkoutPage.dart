import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:happysmacks/models/cart.dart';
import 'package:happysmacks/services/cartService.dart';
import 'package:happysmacks/views/paymentOptionPage.dart';

import 'cartPage.dart';

class CheckOutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        secondaryHeaderColor: Colors.greenAccent,
      ),
      home: new CheckOutItems(),
    );
  }
}

class CheckOutItems extends StatefulWidget {
  @override
  _CheckOutItems createState() => _CheckOutItems();
}

class _CheckOutItems extends State<CheckOutItems> {
  _CheckOutItems() {
    populateCart();
  }


  List<TableRow> tableRowList = [];
  int badgeCount = 0;
  var carts;

  Future<void> populateCart() async {
    CartService cartService = new CartService();
    await cartService.createDatabase();
    carts = await cartService.getSelectedCarts();
    double total = 0;

    setState(() {
      badgeCount = carts.length;
    });

    for (final crt in await carts) {
      total = total + crt['price'];
      tableRowList.add(new TableRow(children: [
        Container(
            padding: const EdgeInsets.all(15),
            child: Text(crt['sku'].toString())),
         Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Text(crt['name'])),
        Container(
            padding: const EdgeInsets.all(15),
            child: Text('\$' + crt['price'].toStringAsFixed(2), textAlign: TextAlign.right)),
      ]));
    }

    tableRowList.add(new TableRow(children: [
      Container(padding: const EdgeInsets.all(15), child: Text('Total')),
      Container(padding: const EdgeInsets.all(15), child: Text(' ')),
      Container(padding: const EdgeInsets.all(15), child: Text('\$' + total.toStringAsFixed(2), textAlign: TextAlign.right
      ))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Checkout'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartPage())),
          )),
      body: Center(
        child: ListView(padding: const EdgeInsets.all(0), children: <Widget>[
          Container(
            margin: const EdgeInsets.all(15),
            child: Text(
              'Juan Dela Cruz',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Text(
              '123 Edge Street, Cebu City, Philippines',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Text(
              '0123-12345678',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Text(
              'juan.delacruz@someemail.com',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Table(
              border: TableBorder(
                  horizontalInside: BorderSide(
                      width: 1, color: Colors.blue, style: BorderStyle.solid)),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FractionColumnWidth(.3),
                1: FractionColumnWidth(.4),
                2: FractionColumnWidth(.3)
              },
              children: tableRowList,
            ),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, floatingActionButton:
        Container( height: 50, width: 250, child : FloatingActionButton.extended(
          backgroundColor: Colors.red,
          onPressed: () =>
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PaymentOptionPage())),

          tooltip: 'Place Order',
          label: Text('Place Order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),),
    );
  }
}
