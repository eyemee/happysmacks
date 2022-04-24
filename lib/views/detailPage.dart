import 'dart:ffi';

/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:happysmacks/models/cart.dart';
import 'package:happysmacks/services/cartService.dart';
import 'package:happysmacks/views/itemsPage.dart';


class DetailPage extends StatelessWidget {
  String itemPicture;
  double price;
  String name;
  int sku;
  DetailPage(String pic, double price, String name, int sku) {
    this.itemPicture = pic;
    this.price = price;
    this.name = name;
    this.sku = sku;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Greeting Card Details'),
      ),
      body: Center(
        child: ListView(padding: const EdgeInsets.all(0), children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 40.0),
            child: Stack(children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                height: 250,
                alignment: Alignment.center,
                child: Image.asset(
                  this.itemPicture,
                  width: 250,
                  height: 250,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                height: 20,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.topCenter,
                child: Text(
                  'Greeting Card',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 17.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 265.0),
                height: 20,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.topCenter,
                child: Text(
                  'SKU:' + sku.toString(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 17.0,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 285.0),
                height: 20,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                alignment: Alignment.topCenter,
                child: Text(
                  '\$' + price.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 17.0,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Container(
                  width: 250,
                  margin: const EdgeInsets.only(top: 310.0),
                  child: FlatButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () async {
                      try {
                        CartService cs = new CartService();
                        await cs.createDatabase();
                        final cart = Cart(name: this.name, price: this.price, sku: this.sku, pic: this.itemPicture);
                        await cs.createCart(cart);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ItemsPage()));
                      } catch(e) {
                        print(e);
                      }
                    },
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
