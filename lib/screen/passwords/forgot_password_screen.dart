import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title:
        Text(
            S.current.ForgotPasswordTitle,
            style: TextStyle(
              color: Color(0xFF262626),
              fontSize: 24,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            )
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
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  RegularText(
                    text: S.current.ForgotPasswordDescription,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text(
                        S.current.EmailAddress,
                        style: TextStyle(
                          color: Color(0xFF262626),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ]
                  ),
                  const SizedBox(height: 2),
                  BaseTextField(
                      hintText: S.current.HintEmail,
                      controller: _emailController,
                      enabled: false
                  ),
                  const SizedBox(height: 50),
                  BaseElevatedButton(
                      text: S.current.SendButton,
                      onPressed: (){}
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