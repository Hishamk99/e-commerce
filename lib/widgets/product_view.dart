import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/helper/get_product_by_category.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/product_info.dart';
import 'package:flutter/material.dart';

Widget productView(String pCategory, List<ProductModel> kProducts) {
  return StreamBuilder<QuerySnapshot>(
    stream:
        FirebaseFirestore.instance.collection(kProductCollection).snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<ProductModel> productList = [];
        for (int i = 0; i < snapshot.data!.docs.length; i++) {
          var data = snapshot.data!.docs[i];
          productList.add(
            ProductModel(
              id: data.id,
              price: data[kProductPrice] ?? '',
              name: data[kProductName] ?? '',
              category: data[kProductCategory] ?? '',
              location: data[kProductLocation] ?? '',
              desc: data[kProductDecsription] ?? '',
            ),
          );
        }
        kProducts = [...productList];
        productList.clear();
        productList = getProductByCategory(pCategory, kProducts);
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .9,
            ),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                  Navigator.pushNamed(context, ProductInfoPage.id ,arguments: productList[index]);
                },
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          productList[index].location!,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Opacity(
                          opacity: .6,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    productList[index].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$ ${productList[index].price}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      } else {
        return const Text('Loading');
      }
    },
  );
}
