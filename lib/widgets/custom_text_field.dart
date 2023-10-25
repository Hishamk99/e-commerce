import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';

class CustomextField extends StatelessWidget {
  const CustomextField({super.key , required this.hint , required this.icon});
  final String hint;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return TextField(
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
            borderSide: const BorderSide(color: Colors.white)),
      ),
    );
  }
}
