import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/edit_products.dart';
import 'package:e_commerce/screens/home_screen.dart';
import 'package:e_commerce/services/store.dart';
import 'package:flutter/material.dart';

class ManageProducts extends StatefulWidget {
  const ManageProducts({super.key});
  static String id = 'ManageProducts';

  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
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
                id: data.id,
                price: data[kProductPrice] ?? '',
                name: data[kProductName] ?? '',
                category: data[kProductCategory] ?? '',
                location: data[kProductLocation] ?? '',
                desc: data[kProductDecsription] ?? '',
              ),
            );
          }
          return SafeArea(
            child: Scaffold(
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .9,
                ),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTapUp: (details) async {
                        double dx = details.globalPosition.dx;
                        double dy = details.globalPosition.dy;
                        double dx1 = MediaQuery.of(context).size.width - dx;
                        double dy1 = MediaQuery.of(context).size.width - dy;
                        await showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(dx, dy, dx1, dy1),
                            items: [
                              PopupMenuItem(
                                onTap: () async {
                                  final navigator = Navigator.of(context);
                                  await Future.delayed(Duration.zero);
                                  navigator.pushNamed(EditProducts.id,
                                      arguments: productList[index]);
                                },
                                child: const Text('Edit'),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  store.deleteProduct(productList[index].id);
                                },
                                child: const Text('Delete'),
                              ),
                            ]);
                      },
                      child: GestureDetector(
                        onTap: ()
                        {
                          Navigator.pushNamed(context, HomeScreen.id);
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const SafeArea(
            child: Scaffold(
              body: Text('Loading...'),
            ),
          );
        }
      },
    );
  }
}

// class MyPopupMenuItem<T> extends PopupMenuItem<T> {
//   const MyPopupMenuItem({Widget? child,required this.onClick}) :super(child: child);
//   final Function onClick;

//   @override
//   PopupMenuItemState<T, PopupMenuItem<T>> createState() => MyPopupMenuItemState();
// }

// class MyPopupMenuItemState<T, PopupMenuItem>
//     extends PopupMenuItemState<T, MyPopupMenuItem<T>> {
//   @override
//   void handleTap() {
//     widget.onClick;
//     print('heloo jdjd');
//     super.handleTap();
    
//     Navigator.pop(context);
//   }
// }
