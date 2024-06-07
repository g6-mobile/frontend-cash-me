import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pocket_swap_fisi/widget/text.dart';
import 'package:pocket_swap_fisi/widget/text_field.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:pocket_swap_fisi/screen/auth/email_verification_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../generated/l10n.dart';
import '../../widget/button.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{
  bool _obscureText = true;
  bool _isKeyboardVisible = false;
  bool _isPasswordInvalid = false;
  bool _isLoading = false;
  bool _isAcceptTerms = false;
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _studentCodeController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _studentCodeController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _studentCodeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Center(
                    child: Column(
                      children: [
                        TitleText(
                            text: S.current.Register
                        ),
                        const SizedBox(height: 42),
                        BaseTextField(
                            hintText: S.current.RegisterName,
                            controller: _nameController
                        ),
                        const SizedBox(height: 20),
                        BaseTextField(
                            hintText: S.current.RegisterLastName,
                            controller: _lastNameController
                        ),
                        const SizedBox(height: 20),
                        BaseTextField(
                            hintText: S.current.RegisterStudentCode,
                            controller: _studentCodeController
                        ),
                        const SizedBox(height: 20),
                        BaseTextField(
                            hintText: S.current.RegisterInstitutionalEmail,
                            controller: _emailController
                        ),
                        const SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            BaseTextField(hintText: S.current.HintPassword,
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
                        const SizedBox(height: 5),
                        Visibility(
                          visible: _isPasswordInvalid,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: HelperText(
                              text: S.current.RegisterPasswordRequired,
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                            Checkbox(
                                value: _isAcceptTerms,
                                onChanged: (bool? value){
                                  setState(() {
                                    _isAcceptTerms = value!;
                                  });
                                }
                                ,checkColor: Colors.white,
                            ),
                            SizedBox(width: 3),
                            GestureDetector(
                              onTap: (){
                                const url = 'https://www.google.com';
                                Uri uri = Uri.parse(url);
                                launchUrl(uri, mode: LaunchMode.externalApplication);
                              },
                              child:
                              Text(
                                S.current.AcceptTerms,
                                style: TextStyle(
                                  color: Color(0xFF959595),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Poppins',
                                  decoration: TextDecoration.underline,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ]
                        ),
                        const SizedBox(height: 20),
                        BaseElevatedButton(
                            text: S.current.RegisterButton,
                            isLoading: _isLoading,
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              if(isValidPassword(_passwordController.text)
                                  && isAcceptTerms(_isAcceptTerms)
                                  && isValidEmail(
                                      _emailController.text,
                                      context))
                              {
                                var register = await authProvider.register(
                                  _nameController.text,
                                  _lastNameController.text,
                                  _studentCodeController.text,
                                  _emailController.text,
                                  _passwordController.text,
                                );
                                registerStatus(
                                    register!,
                                    context,
                                    _emailController
                                );
                              }
                              setState(() {
                                _isLoading = false;
                              });
                            }
                        ),
                      ],
                    )
                  ),
                )

            ]
          )
        )
      ),
    );
  }

  bool isValidPassword(String password) {
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=|<>?{}[\].~-])(?=.*[a-z]).{8,}$',
    );
    print("isValidPassword: ${passwordRegExp.hasMatch(password)}");

    setState(() {
      _isPasswordInvalid = !passwordRegExp.hasMatch(password);
    });

    return passwordRegExp.hasMatch(password);
  }

  bool isAcceptTerms(bool isAcceptTerms){
    if(!isAcceptTerms){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.current.RegisterTermsSnackBar),
        ),
      );
    }
    return isAcceptTerms;
  }
}

void registerStatus(int response, BuildContext context, TextEditingController emailController){
  switch (response) {
    case 201:
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmailVerificationScreen(email: emailController.text),
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

bool isValidEmail(String email, BuildContext context) {
  if (email.isEmpty || !email.endsWith('@unmsm.edu.pe')) {
    print("isValidEmail: false");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(S.current.ForgotPasswordSnackBar),
      ),
    );
    return false;
  }else{
    return true;
  }
}