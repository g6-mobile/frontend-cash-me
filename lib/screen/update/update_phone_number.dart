import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
import 'package:pocket_swap_fisi/widget/text_field.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import '../../generated/l10n.dart'; //S

@RoutePage()
class UpdatePhoneNumber extends StatefulWidget {
  const UpdatePhoneNumber({Key? key}) : super(key: key);

  @override
  State<UpdatePhoneNumber> createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber> {
  
  late TextEditingController _phoneUpdateController;
  
  @override
  void initState() {
    super.initState();
    _phoneUpdateController = TextEditingController();
  }
  
  
  @override
  void dispose() {
    _phoneUpdateController.dispose();
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
            Text("Actual Phone Number"),
            const SizedBox(height: 10),
            
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: '926471336',
                hintStyle: TextStyle(
                  color: Color(0xFFC8C8C8),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC8C8C8)),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              ),
            ),
            
            const SizedBox(height: 30),
            Text("New Phone Number"),
            const SizedBox(height: 10),

            BaseTextField(
              hintText: 'New Phone Number', 
              controller: _phoneUpdateController,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 50),

            BaseElevatedButton(
              text: S.current.ConfirmUpdate,
              onPressed: () async {}
            ),
          ],
        ),
      ),
    );
  }
  
  bool isValidPeruvianPhoneNumber(String phoneNumber) {
    final RegExp phoneNumberRegExp = RegExp(
      r'^[9][0-9]{8}$',
    );
    return phoneNumberRegExp.hasMatch(phoneNumber);
  }
}
