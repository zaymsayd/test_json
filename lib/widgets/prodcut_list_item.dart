import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_json/models/product.dart';
import 'package:test_json/providers/product_provider.dart';

class ProductListItem extends StatefulWidget {
  final Product? product;
  const ProductListItem({Key? key, this.product}) : super(key: key);

  @override
  State<ProductListItem> createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  Color? _selectedColor;
  int _selectedBrand = 0;
  final TextEditingController _controller = TextEditingController(text: "0");
  int qty = 0;
  @override
  void initState() {
    super.initState();
    _selectedColor = widget.product?.colors?.first.color ?? Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(
            backgroundImage: NetworkImage(
              widget.product?.picture ?? "",
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
              Text(widget.product?.productName ?? ""),
              Text(widget.product?.price ?? ""),
              Row(
                children: widget.product?.colors
                        ?.map((e) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio(
                                  value: e.color,
                                  groupValue: _selectedColor,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedColor = value;
                                    });
                                  },
                                ),
                                Text(e.text ?? "")
                              ],
                            ))
                        .toList() ??
                    [],
              ),
              DropdownButton(
                  value: _selectedBrand,
                  items: widget.product?.brands
                      ?.map((e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name ?? ""),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBrand = value ?? 0;
                    });
                  }),
              SizedBox(
                  width: 70,
                  child: TextFormField(
                    controller: _controller,
                    maxLines: 1,
                    onChanged: (value) {
                      if (_controller.text.isNotEmpty) {
                        qty = int.parse(_controller.text);

                      }

                      if (widget.product != null) {
                        Product product = widget.product!;
                        if (_controller.text.isEmpty || qty == 0) {
                          context
                              .read<ProductProvider>()
                              .removeFromCart(product);
                        }
                        if (qty != 0 && _controller.text.isNotEmpty) {
                          context
                              .read<ProductProvider>()
                              .addToCart(product, qty,_selectedColor ?? Colors.transparent,_selectedBrand);
                        }
                      }
                      print(context.read<ProductProvider>().cartList?.length);
                    },
                    decoration: InputDecoration(
                      hintText: "QTY",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  )),
            ],
          ),
        )
      ]),
    );
  }
}
