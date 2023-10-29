import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = Auth();
  int tapBarIndex = 0;
  int bottomBarIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: bottomBarIndex,
              fixedColor: kMainColor,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                setState(() {
                  bottomBarIndex = value;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  //backgroundColor:kMainColor,
                  label: 'dsds',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'dsds',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'dsds',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'dsds',
                  icon: Icon(Icons.person),
                ),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (value) {
                  setState(() {
                    tapBarIndex = value;
                  });
                },
                tabs: [
                  Text(
                    'Jackets',
                    style: TextStyle(
                      fontSize: 12,
                      color: tapBarIndex == 0 ? Colors.black : kUnActiveColor,
                    ),
                  ),
                  Text(
                    'Shoes',
                    style: TextStyle(
                      fontSize: 14,
                      color: tapBarIndex == 1 ? Colors.black : kUnActiveColor,
                    ),
                  ),
                  Text(
                    'T-shirts',
                    style: TextStyle(
                      fontSize: 12,
                      color: tapBarIndex == 2 ? Colors.black : kUnActiveColor,
                    ),
                  ),
                  Text(
                    'Trousers',
                    style: TextStyle(
                      fontSize: 10,
                      color: tapBarIndex == 3 ? Colors.black : kUnActiveColor,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                jacketView(),
                Container(),
                Container(),
                Container(),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'DISCOVER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.shopping_cart),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget jacketView() {
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
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          productList[index].location,
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
}
