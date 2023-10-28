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
   Stream<QuerySnapshot> loadProduct() 
   {
    return FirebaseFirestore.instance.collection(kProductCollection).snapshots();
   }
  // {
  //   var product =  FirebaseFirestore.instance.collection(kProductCollection).get();
  //   List<ProductModel> products = [];
  //   for (var doc in product.docs) {
  //     var data = doc.data();
  //     products.add(ProductModel(
  //       price : data[kProductPrice],
  //       name: data[kProductName],
  //       category: data[kProductCategory],
  //       location: data[kProductCategory],
  //       desc: data[kProductDecsription],
  //     ),);
  //   }
  // }
}
