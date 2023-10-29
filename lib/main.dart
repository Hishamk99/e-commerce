import 'package:e_commerce/screens/edit_products.dart';
import 'package:e_commerce/screens/login_screen.dart';
import 'package:e_commerce/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'provider/admin_mode.dart';
import 'screens/add_product.dart';
import 'screens/admin_screen.dart';
import 'screens/home_screen.dart';
import 'screens/mange_product.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminMode>(
      create: (context)=>AdminMode(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.id :(context) =>  const LoginScreen(),
          SignUpScreen.id :(context) => const SignUpScreen(),
          AdminScreen.id :(context) => const AdminScreen(),
          AddProduct.id :(context) => const AddProduct(),
          ManageProducts.id :(context) => const ManageProducts(),
          EditProducts.id :(context) => const EditProducts(),
          HomeScreen.id :(context) => const HomeScreen(),
        },
        initialRoute: HomeScreen.id,
      ),
    );
  }
}