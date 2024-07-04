import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
import 'package:pocket_swap_fisi/widget/text_field.dart';
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
              onPressed: () async {
                if (isValidPeruvianPhoneNumber(_phoneUpdateController.text)){
                  _showConfirmationDialog();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(S.current.RegisterInvalidPhoneSnackBar)));
                }
              }
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Update Phone Number'),
          content: Text('Are you sure you want to update your phone number to ${_phoneUpdateController.text}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              // en este boton va la logica para el back
              onPressed: () {
                _performPhoneNumberChange();
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(118, 43, 43, 1)), // Color RGB 762B2B
              ),
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _performPhoneNumberChange() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Phone number updated successfully to ${_phoneUpdateController.text}'),
      ),
    );
    _phoneUpdateController.clear();
  }
  
  bool isValidPeruvianPhoneNumber(String phoneNumber) {
    final RegExp phoneNumberRegExp = RegExp(
      r'^[9][0-9]{8}$',
    );
    return phoneNumberRegExp.hasMatch(phoneNumber);
  }
}
