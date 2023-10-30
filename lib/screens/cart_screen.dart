import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/provider/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static String id = 'CartScreen';

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = Provider.of<CartItem>(context).products;
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(products[index].name),
                Text(products[index].kQuantity.toString()),
              ],
            );
          },
        ),
      ),
    );
  }
}
