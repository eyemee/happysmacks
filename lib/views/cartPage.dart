import 'package:badges/badges.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happysmacks/models/cart.dart';
import 'package:happysmacks/services/cartService.dart';
import 'package:happysmacks/views/itemsPage.dart';
import '../views/checkoutPage.dart';
import 'package:circular_check_box/circular_check_box.dart';

import 'detailPage.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        secondaryHeaderColor: Colors.greenAccent,
      ),
      home: new CartItemsPage(),
    );
  }
}

class CartItemsPage extends StatefulWidget {
  @override
  _CartItemsPage createState() => _CartItemsPage();
}

class _CartItemsPage extends State<CartItemsPage> {
  _CartItemsPage() {
    populateCart();
  }

  var carts;
  List<TableRow> tableRowList = [];
  List<Cart> checkOutList = [];
  int badgeCount = 0;
  int selectedCount = 0;
  List<bool> firstValue = [];

  void deleteCart(int id) async {
    CartService cartService = new CartService();
    await cartService.createDatabase();
    await cartService.deleteCart(id);
    setState(() {
      tableRowList = [];
      populateCart();
    });
  }

  showAlert(BuildContext context, int cartId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Item Delete.'),
          content: Text("Are You Sure Want To Delete Item?"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "DELETE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                deleteCart(cartId);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "CANCEL",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blueGrey,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> populateCart() async {
    tableRowList = [];
    selectedCount = 0;
    CartService cartService = new CartService();
    await cartService.createDatabase();
    carts = await cartService.getCarts();

    setState(() {
      badgeCount = carts.length;
    });

    for (final crt in carts) {
      if (crt['forCheckout'] == 1) {
        selectedCount++;
      }
      firstValue.add(crt['forCheckout'] == 0 ? false : true);
    }

    for (int i = 0; i < carts.length; i++) {
      this.firstValue[i] = carts[i]['forCheckout'] == 0 ? false : true;
      tableRowList.add(new TableRow(children: [
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) =>
              CircularCheckBox(
            value: this.firstValue[i],
            onChanged: (value) {
              setState(() {
                this.firstValue[i] = value;
                Cart cart = new Cart(
                    sku: carts[i]['sku'],
                    price: carts[i]['price'],
                    name: carts[i]['name'],
                    id: carts[i]['id'],
                    forCheckout: carts[i]['forCheckout'],
                    pic: carts[i]['pic']
                );
                if (this.firstValue[i] == true) {
                  checkOutList.add(cart);
                  cart = new Cart(
                      sku: carts[i]['sku'],
                      price: carts[i]['price'],
                      name: carts[i]['name'],
                      id: carts[i]['id'],
                      forCheckout: 1,
                      pic: carts[i]['pic']
                  );
                  cartService.updateCart(cart);
                  selectedCount++;
                  this.populateCart();
                } else {
                  checkOutList.remove(cart);
                  cart = new Cart(
                      sku: carts[i]['sku'],
                      price: carts[i]['price'],
                      name: carts[i]['name'],
                      id: carts[i]['id'],
                      forCheckout: 0,
                      pic: carts[i]['pic']
                  );
                  cartService.updateCart(cart);
                  selectedCount = selectedCount - 1;
                  this.populateCart();
                }
              });
            },
          ),
        ),
        Text(carts[i]['sku'].toString()),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(carts[i]['pic'],carts[i]['price'],carts[i]['name'],carts[i]['sku'])
                )
            );
          },
          child: Text(carts[i]['name']),
        ),
        Text('\$' + carts[i]['price'].toStringAsFixed(2),
            textAlign: TextAlign.right),
        FlatButton(
            onPressed: () => showAlert(context, carts[i]['id']),
            child: IconButton(icon: Icon(Icons.delete)))
      ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('My Shopping Cart'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => ItemsPage())),
          )),
      body: Center(
        child: ListView(padding: const EdgeInsets.all(0), children: <Widget>[
          Container(
            margin: const EdgeInsets.all(15),
            child: Table(
              border: TableBorder(
                  horizontalInside: BorderSide(
                      width: 1, color: Colors.blue, style: BorderStyle.solid)),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: {
                0: FractionColumnWidth(.1),
                1: FractionColumnWidth(.2),
                2: FractionColumnWidth(.3),
                3: FractionColumnWidth(.2),
                4: FractionColumnWidth(.2),
              },
              children: tableRowList,
            ),
          ),
          Container(
            height: 450,
            child: Visibility(
                  visible: badgeCount == 0 ? true: false,
                  child:
                  Center( child:
                    Badge(
                      badgeColor: Colors.grey,
                      badgeContent:  Text(badgeCount.toString(), style: TextStyle(color: Colors.white)),
                    child:
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 60,
                      color: Colors.grey,
                    ),
                    ),
                  ),
            ),
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        width: 250,
        child: FloatingActionButton.extended(
          backgroundColor: selectedCount == 0 ? Colors.grey : Colors.red,
          onPressed: () {
            selectedCount > 0
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckOutPage()))
                : null;
          },
          tooltip: 'Checkout',
          label: Text('Proceed to Checkout',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
      ),
    );
  }
}
