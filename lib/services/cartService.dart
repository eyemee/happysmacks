import 'package:happysmacks/models/userage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:happysmacks/models/cart.dart';

class CartService {
  var database;

  createDatabase() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'my.db');

    database = await openDatabase(dbPath, version: 1, onCreate: populateDb);
    return database;
  }

  void populateDb(Database database, int version) async {
    await database.execute("CREATE TABLE cart (id INTEGER PRIMARY KEY, name TEXT,price DOUBLE, sku INTEGER, forCheckout INTEGER, pic TEXT)");
    await database.execute("CREATE TABLE userage (age INTEGER, bdate TEXT)");
  }

  createCart(Cart cart) async {
    final db = await database;
    var maxIdResult = await db.rawQuery(
        "SELECT MAX(id)+1 as last_inserted_id FROM CART");

    var id = maxIdResult.first["last_inserted_id"];
    var forCheckout = 0; //initial zero not for checkout
    var result = await db.rawInsert(
        "INSERT Into CART (id, name, price, sku, forCheckout, pic)"
            " VALUES (?, ?, ?, ?, ?, ?)",
        [id, cart.name, cart.price, cart.sku, forCheckout, cart.pic]
    );
    return result;
  }

  createAge(Userage userage) async {
    final db = await database;
    var result = await db.rawInsert(
        "INSERT Into userage (age, bdate)"
            " VALUES (?, ?)",
        [userage.age, userage.bdate]
    );
    return result;
  }

  deleteCart(int id) async {
    final db = await database;
    db.delete("cart", where: "id = ?", whereArgs: [id]);
  }

  deletePurchased() async {
    final db = await database;
    db.delete("cart", where: "forCheckout = ?", whereArgs: [1]);
  }

  updateCart(Cart cart) async {
    try {
      final db = await database;
      return await db.update("cart", cart.toMap(), where: "id = ?", whereArgs: [cart.id]);
    }catch(e) {
      print(e.toString());
    }
  }

  Future<List> getCarts() async {
    var result = await database.query("cart", columns: ["id", "name", "price","sku","forCheckout","pic"]);
    return result.toList();
  }

  Future<bool> anAdult() async {
    var result = await database.query("userage", columns: ["age", "bdate"]);
    var userRecord = result.toList();
    bool anAdult = false;

    for(final record in userRecord) {
      if(record['age'] >= 18) {
        anAdult = true;
      }
    }

    return anAdult;
  }

  Future<List> getSelectedCarts() async {
    var result = await database.rawQuery("SELECT * FROM Cart WHERE forCheckout = 1");
    return result.toList();
  }

}