import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/services/store.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});
  static String id = 'EditProduct';

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  Store store = Store();
  CollectionReference products =
      FirebaseFirestore.instance.collection(kProductCollection);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: products.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ProductModel> productList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            var data = snapshot.data!.docs[i];
            productList.add(
              ProductModel(
                price: data[kProductPrice] ?? '',
                name: data[kProductName]??'',
                category: data[kProductCategory]?? '',
                location: data[kProductCategory]?? '',
                desc: data[kProductDecsription]?? '',
              ),
            );
          }
          return SafeArea(
            child: Scaffold(
              body: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return Text(productList[index].name);
                },
              ),
            ),
          );
        } else {
          return const SafeArea(
            child: Scaffold(
              body:  Text('Loading...'),
            ),
          );
        }
      },
    );
  }
}
