import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget{
  final String hintText;
  final bool obscureText;
  final bool enabled;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const BaseTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    this.enabled = true,
    required this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xFFC8C8C8),
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC8C8C8)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      ),
    );
  }
}