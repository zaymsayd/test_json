import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_json/models/product.dart';
import 'package:test_json/providers/product_provider.dart';

import '../models/cart_item_model.dart';

class CartItem extends StatelessWidget {
  final CartItemModel? cartItem;
  const CartItem({Key? key, this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
            backgroundImage: NetworkImage(
              cartItem?.product.picture ?? "",
            ),
            minRadius: 50),
        const SizedBox(
          width: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cartItem?.product.productName ?? ""),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "QTY: ${cartItem?.qty ?? 0}"),
                  SizedBox(width: 50,),
                  Text("Price: ${cartItem?.product.price ?? " "}"),
                ],
              ),
              Text("Selected Color: ${cartItem?.product.colors?.where((element) => element.color == cartItem?.selectedColor).first.text ?? ""}"),
              Text("Selected Brand: ${cartItem?.selectedBrand}"),
              Text("Total Price: ${totalAmount(cartItem?.product.price ?? "0", cartItem?.qty ?? 0)}"),
            ],
          ),
        )
      ]),
    );
  }

  String totalAmount(String price,int qty) {
    String value = "";
    price = price.replaceAll("\$","").replaceAll(",", "");
    double? priceValue = double.tryParse(price);
    if(priceValue != null) {
      double total = priceValue * qty;
      value = '\$$total';
    }
    return value;
  }
}
