import 'package:e_commerce/constants.dart';
import 'package:e_commerce/helper/show_snack_bar.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/widgets/logo.dart';
import 'package:e_commerce/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'SignUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isLoading = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? email, password;

  final auth = Auth();

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
                  CustomTextField(
                    onSaved: (value) {},
                    hint: 'Enter your Name',
                    icon: const Icon(Icons.person),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomTextField(
                    onSaved: (value) {
                      email = value;
                    },
                    hint: 'Enter your Email',
                    icon: const Icon(Icons.email),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomTextField(
                    onSaved: (value) {
                      password = value;
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
                          final res = await auth.signUp(email!.trim(), password!.trim());
                          debugPrint(res.user!.email);
                          showSnackBar(context, 'success');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(context, 'Weak Password');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context, 'This email is already used');
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
                          'SignUp',
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
                        'Do have an account ?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * .04,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Sign in',
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
