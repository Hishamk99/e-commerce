import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/signup_screen.dart';
import 'package:e_commerce/widgets/logo.dart';
import 'package:e_commerce/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  static String id = 'LoginScreen';
  final GlobalKey<FormState> formKey = GlobalKey();
  String? email , password;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: height * .1,
                ),
                const Logo(),
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
                GestureDetector(
                  onTap: (){
                    if(formKey.currentState!.validate())
                    {

                    }
                  },
                  child: Container(
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
                ),
                SizedBox(
                  height: height * .05
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
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Text(
                        'SignUp',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * .04,
                          color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
