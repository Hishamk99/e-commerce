import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:flutter/material.dart';

import 'order_details_screen.dart';

class ViewOrderScreen extends StatefulWidget {
  const ViewOrderScreen({super.key});
  static String id = 'ViewOrderScreen';

  @override
  State<ViewOrderScreen> createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  CollectionReference allOrders =
      FirebaseFirestore.instance.collection(kOrders);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: allOrders.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text(
                  'There is no orders',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              );
            } else {
              List<OrderModel> orders = [];
              for (var doc in snapshot.data!.docs) {
                orders.add(
                  OrderModel(
                    docId: doc.id,
                    totalPrice: doc[kTotalPrice] ?? '',
                    address: doc[kAdress],
                  ),
                );
              }
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, OrdetDetailsScreen.id,
                            arguments: orders[index].docId);
                      },
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
                                'Total Price = ${orders[index].totalPrice}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Addres = ${orders[index].address}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
