import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_json/providers/product_provider.dart';
import 'package:test_json/widgets/cart_item.dart';

class OrderSummerScreen extends StatelessWidget {
  const OrderSummerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Summery"),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
      body: Consumer<ProductProvider>(
        builder: (context,provider,child) {
          return ListView.builder(
            itemCount: provider.cartList?.length ?? 0,
              itemBuilder: (context, int index) => CartItem(
                    cartItem: context.read<ProductProvider>().cartList?[index],
                  ));
        }
      ),
    );
  }
}
