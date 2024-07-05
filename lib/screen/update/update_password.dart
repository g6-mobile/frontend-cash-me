import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
import 'package:pocket_swap_fisi/widget/text_field.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import '../../generated/l10n.dart'; //S

@RoutePage()
class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  late TextEditingController _actualPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmNewPasswordController;

  @override
  void initState() {
    super.initState();
    _actualPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();
  }
  
  @override
  void dispose() {
    _actualPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SubtitleText(text: S.current.UpdatePhoneNumber, fontWeight: FontWeight.w500),
        centerTitle: true,
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: ListView(
          children: [
            
            const SizedBox(height: 50),
            Text("Write Actual Password"),
            const SizedBox(height: 5),
            BaseTextField(
              hintText: "Actual Password", 
              controller: _actualPasswordController,
              keyboardType: TextInputType.visiblePassword,
            ),

            const SizedBox(height: 20),
            Text("Write New Password"),
            const SizedBox(height: 5),
            BaseTextField(
              hintText: 'New Password', 
              controller: _newPasswordController,
              keyboardType: TextInputType.visiblePassword,
            ),
          
            const SizedBox(height: 20),
            Text("Confirm New Password"),
            const SizedBox(height: 5),
            BaseTextField(
              hintText: 'Confirm New Password', 
              controller: _confirmNewPasswordController,
              keyboardType: TextInputType.visiblePassword,
            ),

            const SizedBox(height: 50),
            BaseElevatedButton(
              text: S.current.ConfirmUpdate,
              onPressed: () {},
            ),

          ],
        ),
      ),
    );
  }

  bool isValidActualPassword(String phoneNumber) {
    final RegExp phoneNumberRegExp = RegExp(
      r'^[9][0-9]{8}$',
    );
    return phoneNumberRegExp.hasMatch(phoneNumber);
  }
}