import 'package:e_commerce/constants.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/widgets/product_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<ProductModel> kProducts = [];
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
              onTap: (value) async{
                if(value == 2)
                {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.clear();
                  await auth.signOut();
                  Navigator.popAndPushNamed(context , LoginScreen.id);
                }
                setState(() {
                  bottomBarIndex = value;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  //backgroundColor:kMainColor,
                  label: 'test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'test',
                  icon: Icon(Icons.person),
                ),
                BottomNavigationBarItem(
                  label: 'Sign Out',
                  icon: Icon(Icons.close),
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
                productView(kJacket, kProducts),
                productView(kShoes, kProducts),
                productView(kTshirt, kProducts),
                productView(kTrousers, kProducts),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'DISCOVER',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.id);
                    },
                    child: const Icon(Icons.shopping_cart),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
