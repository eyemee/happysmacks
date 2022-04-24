import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happysmacks/services/cartService.dart';
import 'package:happysmacks/views/paymentOptionPage.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'itemsPage.dart';

class ExistingCardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        secondaryHeaderColor: Colors.greenAccent,
      ),
      home: new CardsItemsPage(),
    );
  }
}

class CardsItemsPage extends StatefulWidget {
  @override
  _CardsItemsPage createState() => _CardsItemsPage();
}

class _CardsItemsPage extends State<CardsItemsPage> {
  List cards = [
    {
      'cardNumber' : '4242424242424242',
      'expiryDate' : '04/24',
      'cardHolderName' : 'Muhammad Ahsan Ayaz',
      'cvvCode' : '424',
      'showBackView' : false,
    },
    {
      'cardNumber' : '3566002020360505',
      'expiryDate' : '04/23',
      'cardHolderName' : 'Tracer',
      'cvvCode' : '123',
      'showBackView' : false,
    }
  ];

  payViaExistingCard(BuildContext context, card) async {
    CartService cartService = new CartService();
    await cartService.createDatabase();
    await cartService.deletePurchased();
    Navigator.push(context, MaterialPageRoute(builder: (context) => ItemsPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Existing Credit Cards'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => PaymentOptionPage())),
          )),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) {
              var card = cards[index];
              return InkWell(
                onTap: () {
                  payViaExistingCard(context, card);
                },
                child: CreditCardWidget(
                  cardNumber: card['cardNumber'],
                  cardHolderName: card['cardHolderName'],
                  expiryDate: card['expiryDate'],
                  cvvCode: card['cvvCode'],
                  showBackView: false,
                ),
              );
            },
        ),
      )
    );
  }
}
