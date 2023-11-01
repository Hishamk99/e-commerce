import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key , required this.hint , this.icon , @required this.onSaved});
  final String hint;
  final Icon? icon;
  final void Function(String?)? onSaved;
  String? errorMessage(String hint)
  {
    switch(hint)
    {
      case 'Enter Your Name' : return 'Name is empty!!'; 
      case 'Enter your Password' : return 'Password is empty!!'; 
      case 'Enter your Email' : return 'Email is empty!!'; 
      case 'Product Name' : return 'Name is empty!!'; 
      case 'Product Price' : return 'Price is empty!!'; 
      case 'Product Description' : return 'Description is empty!!'; 
      case 'Product Category' : return 'Category is empty!!'; 
      case 'Product Location' : return 'Location is empty!!'; 
      default: return '';
    }
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: (value)
      {
        if(value!.isEmpty)
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
        fillColor: kSecondryColor,
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
