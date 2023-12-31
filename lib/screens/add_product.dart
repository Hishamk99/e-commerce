import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/services/store.dart';
import 'package:e_commerce/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});
  static String id = 'AddProduct';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? name, price, decs, category, location;

  final GlobalKey<FormState> formKey = GlobalKey();

  final store = Store();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: ListView(children: [
              SizedBox(height: MediaQuery.of(context).size.height * .17),
              CustomTextField(
                  hint: 'Product Name',
                  onSaved: (value) {
                    name = value;
                  }),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                  hint: 'Product Price',
                  onSaved: (value) {
                    price = value;
                  }),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                  hint: 'Product Description',
                  onSaved: (value) {
                    decs = value;
                  }),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                  hint: 'Product Category',
                  onSaved: (value) {
                    category = value;
                  }),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                  hint: 'Product Location',
                  onSaved: (value) {
                    location = value;
                  }),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    store.addProduct(ProductModel(
                      name: name!,
                      price: price!,
                      category: category!,
                      desc: decs!,
                      location: location!,
                    ));
                  }
                },
                child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'Add Product',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        //color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
