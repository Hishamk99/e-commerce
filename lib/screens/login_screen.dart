import 'package:e_commerce/constants.dart';
import 'package:e_commerce/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static String id = 'LoginScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
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
              SizedBox(
                height: height * .1,
              ),
              const CustomextField(
                hint: 'Enter your Email',
                icon: Icon(Icons.email),
              ),
              SizedBox(
                height: height * .02,
              ),
              const CustomextField(
                hint: 'Enter your Password',
                icon: Icon(Icons.lock),
              ),
              SizedBox(
                height: height * .05,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .1),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * .04,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child:  Text(
                      'SignUp',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .04,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
