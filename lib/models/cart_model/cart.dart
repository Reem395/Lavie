class Cart {
  int? id;
  late String userId;
  late String productId;
  late String productType;
  late int noProductsInCart;
  Cart(
      {this.id,
      required this.noProductsInCart,
      required this.productId,
      required this.productType,
      required this.userId,
      });

  Cart.fromJson(Map<dynamic, dynamic> map) {
    id = map['id'];
    noProductsInCart = map['noProductsInCart'];
    productId = map['productId'];
    productType = map['productType'];
    userId = map['userId'];
  }

  toJson() {
    return {
      'id': id,
      'noProductsInCart': noProductsInCart,
      'productId': productId,
      'productType': productType,
      'userId': userId,
    };
  }
}
