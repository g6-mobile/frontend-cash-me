import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pocket_swap_fisi/screen/auth/widgets/LoginTextField.dart';

import '../../generated/l10n.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  bool _obscureText = true;
  bool _isKeyboardVisible = false;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget build(BuildContext context) {
    print(S.delegate);  // Imprime el delegado de localización
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 20,
              top: 10,
              child:
              Image.asset(
                'assets/images/logo.png',
                height: 60,
                width: 60,
                alignment: Alignment.centerLeft,
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.current.Login,
                        style: TextStyle(
                          color: Color(0xFF2A2A2A),
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 42),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/google_logo.png',
                          height: 23,
                          width: 23,
                        ),
                        label:
                        Text(
                            S.current.LoginGoogle,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins'
                          )
                        ),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Color(0xFF2A2A2A),
                          backgroundColor: Colors.white,
                          alignment: Alignment.centerLeft,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFFC8C8C8)),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        S.current.LoginEmail,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 20),
                      LoginTextField(
                        hintText: S.current.HintEmail,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          LoginTextField(hintText: S.current.HintPassword,
                              controller: _passwordController,
                              obscureText: _obscureText,
                              keyboardType: TextInputType.visiblePassword,
                          ),
                          IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              print(S.current.ForgotPassword);
                            },
                            child: Text(
                              S.current.ForgotPassword,
                              style: TextStyle(
                                color: Color(0xFF262626),
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          S.current.LoginButton,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF762B2B),
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ]
                  )
                ),
            ),
            Positioned(
              bottom: _isKeyboardVisible ? -40 : 20,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  print("Crear cuenta");
                },
                child: Container(
                  alignment: Alignment.center, // Centra el contenido horizontalmente
                  child: Text.rich(
                    TextSpan(
                      text: S.current.QuestionSignUp,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF2A2A2A),
                        fontFamily: 'Poppins',
                      ),
                      children: [
                        TextSpan(
                          text: S.current.SignUp,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF1F878E), // Color del enlace
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.underline, // Subraya el texto para indicar que es un enlace
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]
        )
      ),
    );
  }
  
}