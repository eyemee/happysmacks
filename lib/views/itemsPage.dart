/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:happysmacks/services/userService.dart';
import '../views/detailPage.dart';
import '../views/cartPage.dart';
import 'package:badges/badges.dart';
import 'package:happysmacks/services/cartService.dart';

import 'ageVerify.dart';

class ItemsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp
    (
        theme: ThemeData(
          primarySwatch: Colors.green,
          secondaryHeaderColor: Colors.greenAccent,
        ),
        home: new WidgetItemsPage(),
    );
  }
}

class WidgetItemsPage extends StatefulWidget {
  @override
  _WidgetItemsPage createState() => _WidgetItemsPage();
}

class _WidgetItemsPage extends State<WidgetItemsPage> {
  _WidgetItemsPage() {
    setBadgeCount();
  }

  var carts;
  var isAdult;
  var showItems = false;

  int badgeCount = 0;
  Future<void> setBadgeCount() async {
    CartService cartService = CartService();
    await cartService.createDatabase();
    carts = await cartService.getCarts();
    isAdult = await cartService.anAdult();

    if(!isAdult) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AgeVerify()));
    }

    setState(() {
      badgeCount = carts.length;
      showItems = isAdult;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        Visibility(
          visible: showItems,
          child:
          ListView(padding: const EdgeInsets.all(0), children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 5),
              child: Stack(children: <Widget>[
                Container(
                  child: Image.asset('lib/images/HappySmackslogo.jpg'),
                ),
                Container(
                  height: 150,
                  padding: EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CartPage()));
                    },
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child:
                        Badge(
                          position : BadgePosition.topStart(top: -5, start: 20),
                          showBadge: badgeCount > 0 ? true: false,
                          badgeColor: Colors.red[900],
                          badgeContent:
                          Text(badgeCount.toString(), style: TextStyle(color: Colors.white)),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
              ]),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(
                                          'lib/images/image1.jpg',3.99,'Greeting Card 1',100001))); //put code to transfer to another screen
                        },
                        child: Image.asset('lib/images/image1.jpg',
                            width: 150, height: 150)),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(
                                          'lib/images/image2.jpg',4,'Greeting Card 2',100002))); //put code to transfer to another screen
                        },
                        child: Image.asset('lib/images/image2.jpg',
                            width: 150, height: 150)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(
                                          'lib/images/image3.jpg',2.99,'Greeting Card 3',100003))); //put code to transfer to another screen
                        },
                        child: Image.asset('lib/images/image3.jpg',
                            width: 150, height: 150)),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(
                                          'lib/images/image4.jpg',5.99,'Greeting Card 4',100004))); //put code to transfer to another screen
                        },
                        child: Image.asset('lib/images/image4.jpg',
                            width: 150, height: 150)),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

}
