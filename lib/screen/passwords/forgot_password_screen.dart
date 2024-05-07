import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_swap_fisi/screen/auth/email_verification_screen.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart';
import 'package:pocket_swap_fisi/widget/text_field.dart';
import '../../generated/l10n.dart';

class ForgotPassword extends StatefulWidget{
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>{
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title:
        SubtitleText(
            text: S.current.ForgotPasswordTitle,
            fontWeight: FontWeight.w500
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/forgot_password.svg',
              width: 200,
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  RegularText(
                    text: S.current.ForgotPasswordDescription,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      RegularText(
                        text: S.current.EmailAddress,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.left,
                      ),
                    ]
                  ),
                  const SizedBox(height: 2),
                  BaseTextField(
                      hintText: S.current.HintEmail,
                      controller: _emailController
                  ),
                  const SizedBox(height: 50),
                  BaseElevatedButton(
                      text: S.current.SendButton,
                      onPressed: (){
                        if (_emailController.text.isEmpty || !_emailController.text.endsWith('@unmsm.edu.pe')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(S.current.ForgotPasswordSnackBar),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EmailVerificationScreen(email: _emailController.text),
                            ),
                          );
                        }
                      }
                  )
                ]
              )
            ),
          ],
        ),
      ),
    );
  }
}