import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';

class Store {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final docoment = FirebaseFirestore.instance.collection(kProductCollection);

  addProduct(ProductModel product) {
    docoment.add({
      kProductName: product.name,
      kProductPrice: product.price,
      kProductDecsription: product.desc,
      kProductCategory: product.category,
      kProductLocation: product.location
    });
  }

  deleteProduct(docId)
  {
    docoment.doc(docId).delete();
  }

  editProduct(data , docId)
  {
    docoment.doc(docId).update(data);
  }

  storeOrders(data , List<ProductModel> products)
  {
    var docsRef = fireStore.collection(kOrders).doc();
    docsRef.set(data);
    for (var product in products) {
      docsRef.collection(kOrdersDetails).doc().set({
        kProductName: product.name,
        kProductPrice: product.price,
        kProductLocation: product.location,
        kQuantity: product.kQuantity,
        kProductCategory :product.category
      });
    }
  }

  // Stream<QuerySnapshot> loadProduct() {
  //   return FirebaseFirestore.instance
  //       .collection(kProductCollection)
  //       .snapshots();
  // }
}
