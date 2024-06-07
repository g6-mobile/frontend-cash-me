import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../generated/l10n.dart';
import '../../widget/text.dart';
import '../../widget/text_field.dart';

class MultiStepRegisterScreen extends StatefulWidget {
  const MultiStepRegisterScreen({Key? key}) : super(key: key);

  @override
  _MultiStepRegisterScreenState createState() =>
      _MultiStepRegisterScreenState();
}

class _MultiStepRegisterScreenState extends State<MultiStepRegisterScreen> {
  int _currentStep = 0;
  bool _obscureText = true;
  bool isLoading = false;
  bool _isKeyboardVisible = false;
  bool _isPasswordInvalid = false;
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
            onStepContinue: _currentStep < 2
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
                title: Text(S.current.RegisterInstitutionalEmail),
                content: BaseTextField(
                    hintText: S.current.RegisterInstitutionalEmail,
                    controller: _emailController),
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
                  if(_emailController.text.isNotEmpty){
                    details.onStepContinue?.call();
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
      default:
        return Container(); // Devuelve un contenedor vacío por defecto
    }
  }
}
