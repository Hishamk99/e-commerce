import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/cart_screen.dart';
import 'package:e_commerce/screens/edit_products.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/screens/product_info.dart';
import 'package:e_commerce/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/admin_mode.dart';
import 'provider/cart_item.dart';
import 'screens/add_product.dart';
import 'screens/admin_screen.dart';
import 'screens/home_screen.dart';
import 'screens/mange_product.dart';
import 'screens/order_details_screen.dart';
import 'screens/view_order_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatefulWidget {
  const EcommerceApp({super.key});

  @override
  State<EcommerceApp> createState() => _EcommerceAppState();
}

class _EcommerceAppState extends State<EcommerceApp> {
  bool isUserLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text(
                  'Loading....',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        } else {
          isUserLoggedIn = snapshot.data!.getBool(kKeepMeLoggedIn)?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<AdminMode>(
                create: (context) => AdminMode(),
              ),
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              routes: {
                LoginScreen.id: (context) => const LoginScreen(),
                SignUpScreen.id: (context) => const SignUpScreen(),
                AdminScreen.id: (context) => const AdminScreen(),
                AddProduct.id: (context) => const AddProduct(),
                ManageProducts.id: (context) => const ManageProducts(),
                EditProducts.id: (context) => const EditProducts(),
                HomeScreen.id: (context) => const HomeScreen(),
                ProductInfoPage.id: (context) => const ProductInfoPage(),
                CartScreen.id: (context) => const CartScreen(),
                ViewOrderScreen.id: (context) => const ViewOrderScreen(),
                OrdetDetailsScreen.id: (context) => const OrdetDetailsScreen(),
              },
              initialRoute:isUserLoggedIn? HomeScreen.id : LoginScreen.id,
            ),
          );
        }
      },
    );
  }
}
