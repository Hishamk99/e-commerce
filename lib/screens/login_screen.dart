import 'package:e_commerce/constants.dart';
import 'package:e_commerce/helper/show_snack_bar.dart';
import 'package:e_commerce/screens/signup_screen.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/widgets/logo.dart';
import 'package:e_commerce/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;
  final auth = Auth();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: SafeArea(
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
                    onSaved: (data) {
                      email = data;
                    },
                    hint: 'Enter your Email',
                    icon: const Icon(Icons.email),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomextField(
                    onSaved: (data) {
                      password = data;
                    },
                    hint: 'Enter your Password',
                    icon: const Icon(Icons.lock),
                  ),
                  SizedBox(
                    height: height * .05,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          formKey.currentState!.save();
                          debugPrint(email);
                          debugPrint(password);
                          final res = await auth.signIn(email!, password!);
                          debugPrint(res.user!.email);
                          showSnackBar(context, 'success');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                                context, 'no user found for tha email');
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(context,
                                'wrong password provided for that user');
                          }
                        }
                        isLoading = false;
                        setState(() {});
                      } else {}
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
                  SizedBox(height: height * .05),
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
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
