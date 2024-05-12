import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/screen/auth/email_verification_screen.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
// import 'package:pocket_swap_fisi/widget/text_field.dart';
import '../../generated/l10n.dart'; //S


class ProfileScreen extends StatefulWidget{
  const ProfileScreen ({Key? key}) : super (key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen>{
  
  @override
  Widget build(BuildContext  context){
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: SubtitleText(
            text: S.current.Account,
            fontWeight: FontWeight.w500
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red, // Color del borde
                  width: 2, // Ancho del borde
                ),
              ),
              child: Center(
                child: Card(
                  child: ListTile(
                    leading: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: Image.asset('assets/images/img_profile_user.png', fit: BoxFit.cover),
                    ),
                    title: Text(
                      'Diego Chavala',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    subtitle: Text('Ing. de Software\n#20203513'),
                  ),
                ),
              ),
            ),
            
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red, // Color del borde
                  width: 2, // Ancho del borde
                ),
              ),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Editar Perfil'),
                    )
                  ),
                  
                ],
              ),
            )
            
          ],
        )
      ),
    );
  }
}