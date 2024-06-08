import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../generated/l10n.dart';
import '../../widget/text.dart';
import '../../widget/text_field.dart';
import '../auth/email_verification_screen.dart';

class MultiStepRegisterScreen extends StatefulWidget {
  const MultiStepRegisterScreen({Key? key}) : super(key: key);

  @override
  _MultiStepRegisterScreenState createState() =>
      _MultiStepRegisterScreenState();
}

class _MultiStepRegisterScreenState extends State<MultiStepRegisterScreen> {
  int _currentStep = 0;
  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;
  bool isLoading = false;
  bool _isKeyboardVisible = false;
  bool _isPasswordInvalid = false;
  bool _isAcceptTerms = false;
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _studentCodeController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;



  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
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
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _togleConfirmPasswordVisibility() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TitleText(text: S.current.Register),
          const SizedBox(
            height: 20,
          ),
          Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepContinue: _currentStep < 3
                ? () => setState(() => _currentStep += 1)
                : null,
            onStepCancel: _currentStep > 0
                ? () => setState(() => _currentStep -= 1)
                : null,
            controlsBuilder: (context, details) => Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    _buildButtonBasedOnStep(_currentStep, details),
                  ],
                ),
              ],
            ),
            steps: [
              Step(
                title: Text(S.current.RegisterStudentCode),
                content: BaseTextField(
                  hintText: S.current.RegisterStudentCode,
                  controller: _studentCodeController,
                  keyboardType: TextInputType.number,
                ),
                state:
                    _currentStep == 0 ? StepState.editing : StepState.complete,
                isActive: _currentStep == 0,
              ),
              Step(
                title: Text(S.current.RegisterName),
                content: Column(children: [
                  BaseTextField(
                    hintText: S.current.RegisterName,
                    controller: _nameController,
                    enabled: false,
                  ),
                  const SizedBox(height: 20),
                  BaseTextField(
                    hintText: S.current.RegisterLastName,
                    controller: _lastNameController,
                    enabled: false,
                  ),
                ]),
                state:
                    _currentStep == 1 ? StepState.editing : StepState.complete,
                isActive: _currentStep == 1,
              ),
              Step(
                title: Text(S.current.RegisterEmailAndPhoneTitle),
                content: Column(
                  children: [
                    BaseTextField(
                        hintText: S.current.RegisterInstitutionalEmail,
                        controller: _emailController
                    ),
                    SizedBox(height: 20),
                    BaseTextField(
                        hintText: S.current.RegisterPhoneNumber,
                        controller: _phoneController,
                        keyboardType: TextInputType.phone
                    ),
                  ],
                ),
                state:
                    _currentStep == 2 ? StepState.editing : StepState.complete,
                isActive: _currentStep == 2,
              ),
              Step(
                title: Text(S.current.HintPassword),
                content: Column(
                  children: [
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        BaseTextField(hintText: S.current.HintPassword,
                          controller: _passwordController,
                          obscureText: _obscureTextPassword,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        IconButton(
                          icon: Icon(
                            _obscureTextPassword
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
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        BaseTextField(hintText: S.current.HintConfirmPassword,
                          controller: _confirmPasswordController,
                          obscureText: _obscureTextConfirmPassword,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        IconButton(
                          icon: Icon(
                            _obscureTextConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: _togleConfirmPasswordVisibility
                        ),
                      ],
                    ),
                  ],
                ),
                state:
                _currentStep == 2 ? StepState.editing : StepState.complete,
                isActive: _currentStep == 2,
              ),
            ],
          )
        ],
      )),
    );
  }

  Widget _buildButtonBasedOnStep(int step, ControlsDetails details) {
    switch (step) {
      case 0:
        return ElevatedButton(
          onPressed: () {
            setState(() {
              isLoading = true;
            });

            if (_studentCodeController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(S.current.RegisterInvalidCodeSnackBar)));
            } else {
              if (true) {
                details.onStepContinue?.call();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(S.current.RegisterInvalidCodeSnackBar)));
              }
            }
            setState(() {
              isLoading = false;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          child: isLoading
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 8,
                    ),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                )
              : Text(
                  S.current.RegisterButton,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontSize: 18,
                    fontFamily: 'Poppins',
                  ),
                ),
        );
      case 1:
        return Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  details.onStepContinue?.call();
                },
                child: Text(S.current.RegisterButton)),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  details.onStepCancel?.call();
                },
                child: Text(S.current.RegisterBack))
          ],
        );
      case 2:
        return Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  if(_emailController.text.isNotEmpty || _emailController.text.endsWith('@unmsm.edu.pe')){
                    if(_phoneController.text.isNotEmpty){
                      details.onStepContinue?.call();
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(S.current.RegisterInvalidPhoneSnackBar)));
                    }
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(S.current.RegisterInvalidEmailSnackBar)));
                  }
                },
                child: Text(S.current.RegisterButton)),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  details.onStepCancel?.call();
                },
                child: Text(S.current.RegisterBack))
          ],
        );
        case 3:
        return Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  if(_passwordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty){
                    if(isValidPassword(_passwordController.text)){
                      if(_passwordController.text == _confirmPasswordController.text){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmailVerificationScreen(email: _emailController.text),
                          ),
                        );
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(S.current.RegisterPasswordRequired)));
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(S.current.RegisterPasswordRequired)));
                    }
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(S.current.RegisterPasswordRequired)));
                  }
                },
                child: Text(S.current.SendButton)),
            const SizedBox(width: 10),
            ElevatedButton(
                onPressed: () {
                  details.onStepCancel?.call();
                },
                child: Text(S.current.RegisterBack))
          ],
        );
      default:
        return Container(); // Devuelve un contenedor vacío por defecto
    }
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
}
