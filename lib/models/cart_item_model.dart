import 'package:flutter/material.dart';
import 'package:test_json/models/product.dart';

class CartItemModel {
  final Color selectedColor;
  final String? selectedBrand;
  final Product product;
  final int qty;

  CartItemModel(
      { required this.selectedColor, this.selectedBrand, required this.product,required this.qty, });
}