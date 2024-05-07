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

class SubtitleText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final FontWeight fontWeight;


  const SubtitleText({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.bold,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 24,
        fontWeight: fontWeight,
        fontFamily: 'Poppins',
      ),
      textAlign: textAlign,
    );
  }
}


class RegularText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;

  const RegularText({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.normal,
    this.textDecoration = TextDecoration.none,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: 16,
        fontWeight: fontWeight,
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

