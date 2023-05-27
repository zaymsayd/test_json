import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_json/models/product.dart';
import 'package:test_json/providers/product_provider.dart';
import 'package:test_json/screens/order_summery_screen.dart';
import 'package:test_json/widgets/prodcut_list_item.dart';

import '../models/cart_item_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<CartItemModel>? cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Product Lists"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5)),
      body: Consumer<ProductProvider>(builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.products?.length ?? 0,
          itemBuilder: (context, int index) =>
              ProductListItem(product: provider.products?[index]),
        );
      }),
      bottomNavigationBar: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Theme.of(context).primaryColor),
          ),
          child: const Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            context.read<ProductProvider>().submitToCart();
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => OrderSummerScreen()));
          }),
    );
  }
}
