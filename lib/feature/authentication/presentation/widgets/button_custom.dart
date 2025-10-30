import 'package:flutter/material.dart';
import 'package:middle_exam/utils/helper/helper_function.dart';

class ButtonLoginCustom extends StatelessWidget {
  const ButtonLoginCustom({super.key, required this.onPressed, required this.text, required this.imageIcon});

  final VoidCallback onPressed;
  final String text;
  final String imageIcon;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: isDarkMode ? Colors.white : Colors.black),
        ),
        fixedSize: Size(double.infinity, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(imageIcon, width: 30),
          Text(text, style: TextStyle(fontSize: 17)),
          SizedBox()
        ],
      ),
    );
  }
}
