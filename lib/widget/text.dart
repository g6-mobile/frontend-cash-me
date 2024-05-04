import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText({
    Key? key,
    required this.text,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 36,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    );
  }
}


class RegularText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextDecoration textDecoration;

  const RegularText({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontFamily: 'Poppins',
        decoration: textDecoration,
      ),
      textAlign: textAlign,
    );
  }
}

class HelperText extends StatelessWidget {
  final String text;

  const HelperText({
    Key? key,
    required this.text,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color(0xFFCA9292),
        fontSize: 10,
        fontWeight: FontWeight.normal,
        fontFamily: 'Poppins',
      ),
    );
  }
}

