import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:flutter/material.dart';

class ViewOrderScreen extends StatefulWidget {
  const ViewOrderScreen({super.key});
  static String id = 'ViewOrderScreen';

  @override
  State<ViewOrderScreen> createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  CollectionReference order = FirebaseFirestore.instance.collection(kOrders);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: order.snapshots(),
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
            }
            else {
              List<OrderModel> orders = [];
              for (var doc in snapshot.data!.docs) {
                orders.add(OrderModel(
                  totalPrice: doc[kTotalPrice] ?? '',
                  address: kAdress,
                ),);
              }
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context , index){
                    return Text('Total Price ${orders[index].totalPrice.toString()}');
                },
              );
            }
          },
        ),
      ),
    );
  }
}
