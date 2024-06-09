import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pocket_swap_fisi/domain/entities/studentByCode.dart';
import 'package:pocket_swap_fisi/domain/entities/user_register.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:provider/provider.dart';
import '../../generated/l10n.dart';
import '../../providers/auth_provider.dart';
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
  late TextEditingController _studentCodeController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late StudentByCode studentByCode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _studentCodeController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    studentByCode = StudentByCode(
      faculty: 'placeholderFaculty',
      major: 'placeholderMajor',
      name: 'placeholderName',
      userPhoto: 'placeholderUserPhoto',
    );
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        _isKeyboardVisible = visible;
      });
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
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

  late AuthProvider authProvider =
      Provider.of<AuthProvider>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
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
                    state: _currentStep == 0
                        ? StepState.editing
                        : StepState.complete,
                    isActive: _currentStep == 0,
                  ),
                  Step(
                    title: Text(S.current.RegisterName),
                    content: BaseTextField(
                      hintText: studentByCode.name,
                      controller: _nameController,
                      enabled: false,
                    ),
                    state: _currentStep == 1
                        ? StepState.editing
                        : StepState.complete,
                    isActive: _currentStep == 1,
                  ),
                  Step(
                    title: Text(S.current.RegisterEmailAndPhoneTitle),
                    content: Column(
                      children: [
                        BaseTextField(
                          hintText: S.current.RegisterInstitutionalEmail,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        BaseTextField(
                            hintText: S.current.RegisterPhoneNumber,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone),
                      ],
                    ),
                    state: _currentStep == 2
                        ? StepState.editing
                        : StepState.complete,
                    isActive: _currentStep == 2,
                  ),
                  Step(
                    title: Text(S.current.HintPassword),
                    content: Column(
                      children: [
                        Stack(
                          alignment: Alignment.centerRight,
                          children: [
                            BaseTextField(
                              hintText: S.current.HintPassword,
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
                            BaseTextField(
                              hintText: S.current.HintConfirmPassword,
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
                                onPressed: _togleConfirmPasswordVisibility),
                          ],
                        ),
                      ],
                    ),
                    state: _currentStep == 2
                        ? StepState.editing
                        : StepState.complete,
                    isActive: _currentStep == 2,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonBasedOnStep(int step, ControlsDetails details) {
    switch (step) {
      case 0: //Student Code
        return RegisterMultiStepButton(
          text: S.current.RegisterButton,
          onPressed: () async {
            setState(() {
              isLoading = true;
            });

            if (!isValidStudentCode(_studentCodeController.text)) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(S.current.RegisterInvalidCodeSnackBar)));
            } else {
              studentByCode = (await authProvider
                  .studentByCode(_studentCodeController.text));
              switch (studentByCode.faculty) {
                case 'notFound':
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.current.RegisterInvalidCodeSnackBar)));
                  break;
                case 'error':
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.current.DefaultErrorStatusCode)));
                  break;
                default:
                  _nameController.text = studentByCode.name;
                  details.onStepContinue?.call();
              }
            }
            setState(() {
              isLoading = false;
            });
          },
          isLoading: isLoading,
        );
      case 1: //Name
        return Row(
          children: [
            RegisterMultiStepButton(
                text: S.current.RegisterButton,
                onPressed: () {
                  details.onStepContinue?.call();
                }),
            const SizedBox(width: 10),
            RegisterMultiStepButton(
                text: S.current.RegisterBack,
                onPressed: () {
                  details.onStepCancel?.call();
                },
                color: Theme.of(context).colorScheme.onPrimary)
          ],
        );
      case 2: //Email and Phone
        return Row(
          children: [
            RegisterMultiStepButton(
                text: S.current.RegisterButton,
                isLoading: isLoading,
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  if (_emailController.text.isNotEmpty &&
                      _emailController.text.endsWith('@unmsm.edu.pe')) {
                    if (_phoneController.text.isNotEmpty &&
                        isValidPeruvianPhoneNumber(_phoneController.text)) {
                      int? response = await authProvider
                          .validateEmail(_emailController.text);
                      switch (response) {
                        case 201:
                          details.onStepContinue?.call();
                          break;
                        case 404:
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  S.current.RegisterEmailNotFoundSnackBar)));
                          break;
                        case 409:
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(S.current.RegisterUserExistsSnackBar)));
                          break;
                        default:
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(S.current.DefaultErrorStatusCode)));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(S.current.RegisterInvalidPhoneSnackBar)));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(S.current.RegisterInvalidEmailSnackBar)));
                  }
                  setState(() {
                    isLoading = false;
                  });
                }),
            const SizedBox(width: 10),
            RegisterMultiStepButton(
                text: S.current.RegisterBack,
                onPressed: () {
                  details.onStepCancel?.call();
                },
                color: Theme.of(context).colorScheme.onPrimary)
          ],
        );
      case 3: //Password
        return Row(
          children: [
            RegisterMultiStepButton(
                text: S.current.RegisterButton,
                onPressed: () {
                  if (_passwordController.text.isNotEmpty &&
                      _confirmPasswordController.text.isNotEmpty) {
                    if (isValidPassword(_passwordController.text)) {
                      if (_passwordController.text ==
                          _confirmPasswordController.text) {
                        UserRegister userRegister = UserRegister(
                            name: _nameController.text,
                            studentCode: _studentCodeController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            password: _passwordController.text);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmailVerificationScreen(
                                email: _emailController.text,
                                userRegister: userRegister),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(S.current.RegisterPasswordRequired)));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(S.current.RegisterPasswordRequired)));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(S.current.RegisterPasswordRequired)));
                  }
                }),
            const SizedBox(width: 10),
            RegisterMultiStepButton(
                text: S.current.RegisterBack,
                onPressed: () {
                  details.onStepCancel?.call();
                },
                color: Theme.of(context).colorScheme.onPrimary)
          ],
        );
      default:
        return Container();
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

  bool isValidStudentCode(String studentCode) {
    final RegExp studentCodeRegExp = RegExp(
      r'^\d{8}$',
    );

    return studentCodeRegExp.hasMatch(studentCode);
  }

  bool isValidPeruvianPhoneNumber(String phoneNumber) {
    final RegExp phoneNumberRegExp = RegExp(
      r'^[9][0-9]{8}$',
    );

    return phoneNumberRegExp.hasMatch(phoneNumber);
  }
}
