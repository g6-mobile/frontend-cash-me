import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
import '../../generated/l10n.dart'; //S

class UpdatePhoneNumber extends StatefulWidget {
  const UpdatePhoneNumber({super.key});

  @override
  State<UpdatePhoneNumber> createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            SubtitleText(text: S.current.EditProfile, fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
    );
  }
}