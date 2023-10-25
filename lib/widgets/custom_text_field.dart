import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';

class CustomextField extends StatelessWidget {
  const CustomextField({super.key , required this.hint , required this.icon , @required this.onSaved});
  final String hint;
  final Icon icon;
  final void Function(String?)? onSaved;
  String? errorMessage(String hint)
  {
    switch(hint)
    {
      case 'Enter Your Name' : return 'Name is empty!!'; 
      case 'Enter your Password' : return 'Password is empty!!'; 
      case 'Enter your Email' : return 'Email is empty!!'; 
      default: return '';
    }
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: (value)
      {
        if(value == null)
        {
          return errorMessage(hint);
        }
        return null;
      },
      obscureText: hint == 'Enter your Password' ? true : false,
      cursorColor: kMainColor,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon,
        filled: true,
        fillColor: kTextFieldColor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white)),    
      ),
    );
  }
}
