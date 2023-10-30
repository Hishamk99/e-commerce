import 'package:e_commerce/models/product_model.dart';

getProductByCategory(String jacket , List<ProductModel>kProducts) {
    List<ProductModel> res = [];
    for (var prod in kProducts) {
      if (jacket == prod.category) {
        res.add(prod);
      }
    }
    return res;
  }