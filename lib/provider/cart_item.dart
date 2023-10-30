import 'package:e_commerce/models/product_model.dart';

import 'package:flutter/widgets.dart';

class CartItem extends ChangeNotifier
{
  List<ProductModel> products = [];
  addProduct(ProductModel product)
  {
    products.add(product);
    notifyListeners();
  }
}