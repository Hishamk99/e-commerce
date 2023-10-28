import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';

class Store {
  //final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final doc = FirebaseFirestore.instance.collection(kProductCollection);

  addProduct(ProductModel product) {
    doc.add({
      kProductName: product.name,
      kProductPrice: product.price,
      kProductDecsription: product.desc,
      kProductCategory: product.category,
      kProductLocation: product.location
    });
  }

  deleteProduct(docId)
  {
    doc.doc(docId).delete();
  }

  editProduct(data , docId)
  {
    doc.doc(docId).update(data);
  }

  // Stream<QuerySnapshot> loadProduct() {
  //   return FirebaseFirestore.instance
  //       .collection(kProductCollection)
  //       .snapshots();
  // }
}
