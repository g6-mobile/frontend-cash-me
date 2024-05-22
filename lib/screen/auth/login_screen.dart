import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:pocket_swap_fisi/screen/home/home_screen.dart';
import 'package:pocket_swap_fisi/screen/register/register_screen.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart';
import 'package:pocket_swap_fisi/widget/text_field.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../passwords/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {  
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
          child: Stack(children: [
        Positioned(
          left: 20,
          top: 10,
          child: Image.asset(
            'assets/images/logo.png',
            height: 60,
            width: 60,
            alignment: Alignment.centerLeft,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                TitleText(
                  text: S.current.Login,
                ),
                const SizedBox(height: 42),
                BaseAssetOutlinedButton(
                    text: S.current.LoginGoogle,
                    onPressed: () {},
                    asset: 'assets/images/google_logo.png'),
                const SizedBox(height: 20),
                RegularText(
                  text: S.current.LoginEmail,
                ),
                const SizedBox(height: 20),
                BaseTextField(
                  hintText: S.current.HintEmail,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    BaseTextField(
                      hintText: S.current.HintPassword,
                      controller: _passwordController,
                      obscureText: _obscureText,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ));
                      },
                      child: RegularText(text: S.current.ForgotPassword),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                BaseElevatedButton(
                    text: S.current.LoginButton,
                    onPressed: () async {
                      try {
                        await authProvider.login(_emailController.text, _passwordController.text);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeScreen()),
                            (Route<dynamic> route) => false,
                            );
                      } catch (e) {
                        print('Error: $e');
                      }
                    })
              ])),
        ),
        Positioned(
          bottom: _isKeyboardVisible ? -40 : 20,
          left: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ));
            },
            child: Container(
              alignment:
                  Alignment.center, // Centra el contenido horizontalmente
              child: Text.rich(
                TextSpan(
                  text: S.current.QuestionSignUp,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontFamily: 'Poppins',
                  ),
                  children: [
                    TextSpan(
                      text: S.current.SignUp,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF1F878E), // Color del enlace
                        fontFamily: 'Poppins',
                        decoration: TextDecoration
                            .underline, // Subraya el texto para indicar que es un enlace
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ])),
    );
  }
}
