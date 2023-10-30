import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';

getProductByCategory(String jacket, List<ProductModel> kProducts) {
  List<ProductModel> res = [];
  try {
    for (var prod in kProducts) {
      if (jacket == prod.category) {
        res.add(prod);
      }
    }
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
  return res;
}
