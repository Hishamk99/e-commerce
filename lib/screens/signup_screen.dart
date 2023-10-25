import 'package:e_commerce/constants.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/widgets/logo.dart';
import 'package:e_commerce/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  static String id = 'SignUp';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? email , password;
  final auth = Auth();
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
                 CustomextField(
                  onSaved: (value)
                  {

                  },
                  hint: 'Enter your Name',
                  icon:const Icon(Icons.person),
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomextField(
                  onSaved: (value)
                  {
                    email = value;
                  },
                  hint: 'Enter your Email',
                  icon: const Icon(Icons.email),
                ),
                SizedBox(
                  height: height * .02,
                ),
                 CustomextField(
                  onSaved: (value)
                  {
                    password = value;
                  },
                  hint: 'Enter your Password',
                  icon: const Icon(Icons.lock),
                ),
                SizedBox(
                  height: height * .05,
                ),
                GestureDetector(
                  onTap: ()async {
                    if(formKey.currentState!.validate())
                    {
                      formKey.currentState!.save();
                      debugPrint(email);
                      debugPrint(password);
                      final res = await auth.signUp(email!, password!);
                      debugPrint(res.user!.email);
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
                        'SignUp',
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
                      'Do have an account ?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * .04,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, SignUpScreen.id);
                      },
                      child: Text(
                        'Sign in',
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