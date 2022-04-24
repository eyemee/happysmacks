class Cart {
 final int id;
 final String name;
 final double price;
 final int sku;
 final int forCheckout;
 final String pic;

 Cart({this.id, this.name, this.price, this.sku, this.forCheckout, this.pic});

 Map<String, dynamic> toMap() {
   return {
     'id': id,
     'name': name,
     'price': price,
     'sku' : sku,
     'forCheckout' : forCheckout,
     'pic' : pic
   };
 }

}