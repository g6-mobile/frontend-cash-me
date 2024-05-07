import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart';
import '../../generated/l10n.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  const EmailVerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen>{

  List<TextEditingController> controllers = List.generate(
    6,
        (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubtitleText(
                  text: S.current.EmailVerificationTitle,
                  textAlign: TextAlign.center
              ),
              const SizedBox(height: 42),
              RegularText(
                text: S.current.EmailVerificationDescription,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              RegularText(
                text: widget.email,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 40),
              Pinput(
                length: 5,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                onChanged: (value) {
                  // Code to execute when there is a change in the entered values
                },
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  // Aquí va el código que se ejecutará cuando se pulse el texto
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    S.current.ResendCode,
                    style: TextStyle(
                      color: Color(0xFF1F878E),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              BaseElevatedButton(text: S.current.LoginButton, onPressed: (){})
            ],
          ),
        ),
      )
    );
  }

}