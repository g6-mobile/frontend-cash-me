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
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 16,
          fontFamily: 'Poppins',
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      ),
    );
  }
}

class CurrencyTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const CurrencyTextField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 50.0),
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      cursorColor: Colors.transparent,
      onChanged: onChanged,
    );
  }
}