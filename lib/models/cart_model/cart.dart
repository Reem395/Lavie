class Cart{

  String? id;
  late String userId;
  late String productId;
  late String productType;
  late int noProductsInCart;
  Cart({this.id, required this.userId,
   required this.productId, required this.noProductsInCart,required this.productType});

  Cart.fromJson(Map<dynamic,dynamic>map){
    id = map['id'];
    userId = map['userId'];
    productId = map['productId'];
    productType = map['productType'];
    noProductsInCart = map['noProductsInCart'];
  }

  toJson(){
    return {
      'id':id,
      'userId':userId,
      'productId':productId,
      'productType':productType,
      'noProductsInCart':noProductsInCart
    };
  }
}