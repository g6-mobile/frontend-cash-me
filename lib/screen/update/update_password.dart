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
  bool _obscureTextActualPassword = true;
  bool _obscureTextNewPassword = true;
  bool _obscureTextConfirmNewPassword = true;
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

  void _toggleVisibilityActualPassword() {
    setState(() {
      _obscureTextActualPassword = !_obscureTextActualPassword;
    });
  }
  void _toggleVisibilityNewPassword() {
    setState(() {
      _obscureTextNewPassword = !_obscureTextNewPassword;
    });
  }
  void _toggleVisibilityConfirmNewPassword() {
    setState(() {
      _obscureTextConfirmNewPassword = !_obscureTextConfirmNewPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SubtitleText(text: S.current.UpdatePassword, fontWeight: FontWeight.w500),
        centerTitle: true,
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: ListView(
          children: [
            
            const SizedBox(height: 50),
            Text(S.current.WriteActualPassword),
            const SizedBox(height: 5),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                BaseTextField(
                  hintText: S.current.ActualPassword, 
                  controller: _actualPasswordController,
                  obscureText: _obscureTextActualPassword,
                  keyboardType: TextInputType.visiblePassword,
                ),
                IconButton(
                  icon: Icon(
                    _obscureTextNewPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: _toggleVisibilityActualPassword,
                ),
              ],
            ),

            

            const SizedBox(height: 20),
            Text(S.current.WriteNewPassword),
            const SizedBox(height: 5),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                BaseTextField(
                  hintText: S.current.NewPassword, 
                  controller: _newPasswordController,
                  obscureText: _obscureTextNewPassword,
                  keyboardType: TextInputType.visiblePassword,
                ),
                IconButton(
                  icon: Icon(
                    _obscureTextNewPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: _toggleVisibilityNewPassword,
                ),
              ],
            ),
            
          
            const SizedBox(height: 20),
            Text(S.current.ConfirmNewPassword),
            const SizedBox(height: 5),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                BaseTextField(
                  hintText: S.current.ConfirmNewPassword, 
                  controller: _confirmNewPasswordController,
                  obscureText: _obscureTextConfirmNewPassword,
                  keyboardType: TextInputType.visiblePassword,
                ),
                IconButton(
                  icon: Icon(
                    _obscureTextConfirmNewPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: _toggleVisibilityConfirmNewPassword,
                ),
              ],
            ),

            const SizedBox(height: 50),
            BaseElevatedButton(
              text: S.current.ConfirmUpdate,
              onPressed: () {}
            ),
          ],
        ),
      ),
    );
  }

  bool isValidPassword(String password) {
    return true;
  }
}