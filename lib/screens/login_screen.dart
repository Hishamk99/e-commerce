import 'package:e_commerce/constants.dart';
import 'package:e_commerce/helper/show_snack_bar.dart';
import 'package:e_commerce/provider/admin_mode.dart';
import 'package:e_commerce/screens/admin_screen.dart';
import 'package:e_commerce/screens/signup_screen.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:e_commerce/widgets/logo.dart';
import 'package:e_commerce/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool isAdmin = false;
  bool keepMeLoggedIn = false;
  final adminPass = 'admin12345';

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
                    onSaved: (data) {
                      email = data;
                    },
                    hint: 'Enter your Email',
                    icon: const Icon(Icons.email),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: kMainColor,
                        activeColor: Colors.green,
                        value: keepMeLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            keepMeLoggedIn = value!;
                          });
                        },
                      ),
                      const Text(
                        'Remember Me',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
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
                    onTap: () {
                      if(keepMeLoggedIn)
                      {
                        keepUserLoggedIn();
                      }
                      _validate(context);
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
                  SizedBox(
                    height: height * .03,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(true);
                            },
                            child: Text(
                              'I\'m an admin',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Provider.of<AdminMode>(context).isAdmin
                                    ? kMainColor
                                    : Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Provider.of<AdminMode>(context, listen: false)
                                  .changeIsAdmin(false);
                            },
                            child: Text(
                              'I\'m a user',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Provider.of<AdminMode>(context).isAdmin
                                      ? Colors.white
                                      : kMainColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validate(BuildContext context) async {
    isLoading = true;
    setState(() {});
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (password == adminPass) {
          try {
            await auth.signIn(email!.trim(), password!.trim());
            Navigator.pushNamed(context, AdminScreen.id);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              showSnackBar(context, 'no user found for tha email');
            } else if (e.code == 'wrong-password') {
              showSnackBar(context, 'wrong password provided for that user');
            }
          } catch (e) {
            debugPrint(e.toString());
          }
        } else {
          showSnackBar(context, 'something went wrong');
        }
      } else {
        try {
          print(isAdmin);
          debugPrint(email);
          debugPrint(password);
          await auth.signIn(email!, password!);
          showSnackBar(context, 'success');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            showSnackBar(context, 'no user found for tha email');
          } else if (e.code == 'wrong-password') {
            showSnackBar(context, 'wrong password provided for that user');
          } else {
            showSnackBar(context, 'error');
          }
        }
      }
    }
    isLoading = false;
    setState(() {});
  }
  
  void keepUserLoggedIn()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
  }
}
