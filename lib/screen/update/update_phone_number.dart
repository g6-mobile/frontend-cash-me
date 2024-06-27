import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
import 'package:pocket_swap_fisi/widget/text_field.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import '../../generated/l10n.dart'; //S


class UpdatePhoneNumber extends StatefulWidget {
  const UpdatePhoneNumber({Key? key}) : super(key: key);

  @override
  State<UpdatePhoneNumber> createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber> {
  
  late TextEditingController _phoneController;
  
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }
  
  
  @override
  void dispose() {
    _phoneController.dispose();
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

            /*
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
              ),
            ),
            */

            BaseTextField(
              hintText: 'hola mundo ctm', 
              controller: _phoneController,
              keyboardType: TextInputType.number,
            ),
            /*
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
            */

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
}
