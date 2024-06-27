import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pocket_swap_fisi/screen/update/update_phone_number.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
import 'package:pocket_swap_fisi/widget/text_field.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../generated/l10n.dart'; //S

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  /*
  bool _obscureText = true;
  bool _isKeyboardVisible = false;
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();

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
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  */
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            SubtitleText(text: S.current.EditProfile, fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          children: [
            const SizedBox(height: 10),
            // imagen de perfil e icons.edit
            Center(
              child: Stack(
                children: [
                  Container(
                    child: ClipOval(
                      // child: Image.network('src'),
                      child: Image.asset(
                        'assets/images/img_profile_user.png',
                        width: 120,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFE7E7),
                      ),
                      child: Icon(
                        Icons.edit, 
                        color: Color(0xFF762B2B),
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Nombre de usuario
            Center(
              child: Text(
                'Estiven Salvador\nHurtado Santos',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF762B2B),
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Text nombre
            const SizedBox(height: 20),
            Text(S.current.RegisterName),
            const SizedBox(height: 5),
            // TextField para Nombre(s)
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: 'Estiven Salvador',
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

            // Text Apellidos
            const SizedBox(height: 10),
            Text(S.current.RegisterLastName),
            const SizedBox(height: 5),
            // TextField Apellidos
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: 'Hurtado Santos',
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

            // Text Codigo universitario
            const SizedBox(height: 10),
            Text(S.current.RegisterStudentCode),
            const SizedBox(height: 5),
            // TextField de codigo
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: '20200284',
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

            // lo que si se puede cambiar es la comtraseña y el phone number
            const SizedBox(height: 10),
            Text(S.current.RegisterPhoneNumber),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePhoneNumber()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: Color(0xFFFFE7E7),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Color(0xFFC8C8C8)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.UpdatePhoneNumber,
                    style: TextStyle(
                      color: Color(0xFF2A2A2A),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  )
                ],
              ),
            ),

            const SizedBox(height: 10),
            Text(S.current.HintPassword),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10),
                backgroundColor: Color(0xFFFFE7E7),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Color(0xFFC8C8C8)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.UpdatePassword,
                    style: TextStyle(
                      color: Color(0xFF2A2A2A),
                      fontSize: 15,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            
            
          ],
        ),
      ),
    );

  }
}