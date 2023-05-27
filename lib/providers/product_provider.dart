import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:test_json/models/product.dart';

import '../models/cart_item_model.dart';

class ProductProvider extends ChangeNotifier {
  List<Product?>? _products = [];
  List<CartItemModel?>? _cartList = [];

  init() async {
    final String data = await rootBundle.loadString("assets/Products.json");
    _products?.clear();
    _products = productFromJson(data);
    if (kDebugMode) {
      print(data);
    }
    notifyListeners();
  }

  addToCart(Product product, int qty, Color color, int brandId) {
        _cartList?.add(CartItemModel(
            selectedColor: color,
            product: product,
            qty: qty,
            selectedBrand: product.brands
                ?.where((element) => element.id == brandId)
                .first
                .name));

    notifyListeners();
  }

  void submitToCart() {}

  removeFromCart(Product product) {
    _cartList?.removeWhere((element) => element?.product == product);
    notifyListeners();
  }

  List<Product?>? get products => _products;
  List<CartItemModel?>? get cartList => _cartList;
}
