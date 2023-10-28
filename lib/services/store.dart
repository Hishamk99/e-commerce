import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';

class Store {
  //final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  addProduct(ProductModel product) {
    FirebaseFirestore.instance.collection(kProductCollection).add({
      kProductName: product.name,
      kProductPrice: product.price,
      kProductDecsription: product.desc,
      kProductCategory: product.category,
      kProductLocation: product.location
    });
  }

  // Stream<QuerySnapshot> loadProduct() {
  //   return FirebaseFirestore.instance
  //       .collection(kProductCollection)
  //       .snapshots();
  // }
}
