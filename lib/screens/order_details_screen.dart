import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:flutter/material.dart';

class OrdetDetailsScreen extends StatelessWidget {
  const OrdetDetailsScreen({super.key});
  static String id = 'OrdetDetailsScreen';
  @override
  Widget build(BuildContext context) {
    String docId = ModalRoute.of(context)!.settings.arguments as String;
    CollectionReference ordersDetails = FirebaseFirestore.instance
        .collection(kOrders)
        .doc(docId)
        .collection(kOrdersDetails);

    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: ordersDetails.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'Loading Orders Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            } else {
              List<ProductModel> orders = [];
              for (var doc in snapshot.data!.docs) {
                orders.add(
                  ProductModel(
                    name: doc[kProductName] ?? '',
                    category: doc[kProductCategory] ?? '',
                    kQuantity: doc[kQuantity] ?? '',
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            height: MediaQuery.of(context).size.height * .2,
                            color: kSecondryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Product Name ${orders[index].name}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Product Category is ${orders[index].category}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Product Quantity ${orders[index].kQuantity}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kMainColor,
                            ),
                            child: const Text(
                              'Confirm Orders',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kMainColor,
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Delete Orders',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
