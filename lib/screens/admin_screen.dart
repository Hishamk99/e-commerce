import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/add_product.dart';
import 'package:e_commerce/screens/edit_product.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});
  static String id = 'AdminScreen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AddProduct.id);
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Add Product',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, EditProduct.id);
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Edit Product',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15,),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'View Order',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}