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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<ProductModel>>(
          future: store.loadProduct(),
          builder: (context, snapshot) {
           if(snapshot.hasData){ 
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data![index].name);
              },
            );
            }
            return const Text('Loading...');
          },
        ),
      ),
    );
  }
}
