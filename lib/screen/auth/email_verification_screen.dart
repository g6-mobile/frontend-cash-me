import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:pocket_swap_fisi/domain/entities/user_register.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../providers/auth_provider.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final UserRegister? userRegister;

  const EmailVerificationScreen(
      {Key? key, required this.email, this.userRegister})
      : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  String verificationCode = '';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        )),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubtitleText(
                    text: S.current.EmailVerificationTitle,
                    textAlign: TextAlign.center),
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
                    verificationCode = value;
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
                BaseElevatedButton(
                  text: S.current.LoginButton,
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    if (verificationCode == '11111') {
                      var register = await authProvider.register(
                        widget.userRegister!.name,
                        "lastName",
                        widget.userRegister!.studentCode,
                        widget.userRegister!.email,
                        widget.userRegister!.password,
                      );
                      registerStatus(register!, context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(S.current.DefaultErrorStatusCode)));
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  isLoading: _isLoading,
                )
              ],
            ),
          ),
        ));
  }

  void registerStatus(int response, BuildContext context){
    switch (response) {
      case 201:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Usuario registrado correctamente")
          ),
        );
        break;
      case 404:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.current.RegisterInvalidCodeSnackBar),
          ),
        );
        break;
      case 409:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.current.RegisterUserExistsSnackBar),
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(S.current.DefaultErrorStatusCode),
          ),
        );
        break;
    }

  }
}
