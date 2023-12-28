import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/cart_model/cart.dart';
import '../../utils/product_utils.dart';
import '../local/database/database_helper.dart';

class CartProvider with ChangeNotifier {
  //****************** Cart ********************************* */
  List userCart = [];
  double cartTotalPrice = 0.0;
  //contains Id of product and intial count in cart (0) assigned with get request
  List<Map<String, int>> cartProdCount = [];
  List<Map<String, int>> cartPlantCount = [];
  List<Map<String, int>> cartSeedsCount = [];
  List<Map<String, int>> cartToolsCount = [];
  incrementCartItem(
      {required dynamic productInstance, required BuildContext context}) {
    String prodId = getInstanceId(productInstance: productInstance);
    //Get Which List to work with
    List productCountListMap =
        getProductListMap(productInstance: productInstance, context: context);

    for (Map item in productCountListMap) {
      if (item.containsKey(prodId)) {
        item[prodId] = (item.values.first) + 1;
        calculateCartTotalPrice(context: context);
        notifyListeners();
      }
    }
  }

  decrementCartItem(
      {required dynamic productInstance,
      required BuildContext context,
      cartId}) {
    String prodId = getInstanceId(productInstance: productInstance);
    List productCountMap =
        getProductListMap(productInstance: productInstance, context: context);

    for (Map item in productCountMap) {
      if (item.containsKey(prodId)) {
        if (item.values.first >= 1) {
          item[prodId] = (item.values.first) - 1;
          if (item.values.first == 0) {
            if (cartId != null) {
              print("cart ID != null $cartId");
              deleteFromCart(cartId: cartId, context: context);
            }
          }
        } else if (item.values.first < 1) {}
        calculateCartTotalPrice(context: context);
        notifyListeners();
      }
    }
  }
  // to display no.items in Home Page
  getCount({required product, required BuildContext context}) {
    var prodId = getInstanceId(productInstance: product);
    for (var item in userCart) {
      if (item.productId == prodId) {
        return item.noProductsInCart;
      }
    }
    return prodCount(productInstance: product, context: context);
  }

  getCart() {
    DatabaseHelper.helper.getuserCart().then((value) {
      print("from getCart cart length : ${value.length}");
      userCart = value;
      notifyListeners();
      return userCart;
    });
  }

//Used in elementToRemove
  void deleteFromCart(
      {required int cartId,
      dynamic productInstance,
      required BuildContext context}) {
    DatabaseHelper.helper.deleteFromDb(cartId).then((value) => value > 0
        ? print('element deleted from cart')
        : print('something went wrong'));
    getCart();

    if (productInstance != null) {
      String prodId = getInstanceId(productInstance: productInstance);
      List productCountListMap =
          getProductListMap(productInstance: productInstance, context: context);
      //To be updated outside cart screen
      for (Map item in productCountListMap) {
        if (item.containsKey(prodId)) {
          item[prodId] = 0;
        }
      }
    }
  }

  void updateCart({required Cart myCart, required BuildContext context}) {
    DatabaseHelper.helper.updateDb(myCart).then((value) =>
        value > 0 ? print('cart updated') : print('something went wrong'));
    getCart();
    calculateCartTotalPrice(context: context);
    notifyListeners();
  }

  addToCart({required Cart myCart, required BuildContext context}) {
    if (myCart.noProductsInCart == 0) {
      Fluttertoast.showToast(
          msg: "Please incerase number of products",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (userCart.isNotEmpty) {
        //if element doesn't exist in cart
        if (!(userCart
            .any((element) => element.productId == myCart.productId))) {
          userCart.add(myCart);
          DatabaseHelper.helper.insertDb(myCart).then((value) => value > 0
              ? Fluttertoast.showToast(
                  msg: "Product Added", toastLength: Toast.LENGTH_SHORT)
              : print('something went wrong from addtoCart'));
          getCart();
        }
      } else {
        userCart.add(myCart);
        DatabaseHelper.helper.insertDb(myCart).then((value) =>
            value > 0 ? print('cart Saved') : print('something went wrong'));
        getCart();
        Fluttertoast.showToast(
            msg: "Product Added", toastLength: Toast.LENGTH_SHORT);
      }
      // for (var element in userCart) {
      //   print("usercart: ${element.productId}");
      // }
    }
    calculateCartTotalPrice(context: context);
    notifyListeners();
  }

  elementToRemove(
      {required elementToRemove,
      required BuildContext context,
      dynamic productInstance}) {
    userCart.remove(elementToRemove);
    calculateCartTotalPrice(context: context);
    deleteFromCart(
        cartId: elementToRemove.id,
        productInstance: productInstance,
        context: context);
    notifyListeners();
  }

  calculateCartTotalPrice({required BuildContext context}) {
    cartTotalPrice = 0.0;
    getCart();
    for (var item in userCart) {
      // fetch the specific product info as obj
      var foundedProduct = productInCart(cartProduct: item, context: context);
      var price = foundedProduct.price;
      var count = item.noProductsInCart;
      cartTotalPrice += price * count;
    }
  }
}
