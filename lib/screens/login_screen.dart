import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String id = 'Login Screen';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                height: MediaQuery.of(context).size.height* .2,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset('images/icons/buyicon.png'),
                    const Positioned(
                      bottom: 0,
                      child: Text(
                        'Buy it',
                        style: TextStyle(fontFamily: 'Pacifico'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
