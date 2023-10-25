import 'package:flutter/material.dart';

class CustomImageText extends StatelessWidget {
  const CustomImageText({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
