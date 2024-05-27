import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/screen/auth/email_verification_screen.dart';
import 'package:pocket_swap_fisi/theme/light_theme.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
// import 'package:pocket_swap_fisi/widget/text_field.dart';
import '../../generated/l10n.dart'; //S
import 'package:shared_preferences/shared_preferences.dart';

import '../../widget/bottom_sheet.dart';



class ProfileScreen extends StatefulWidget{
  const ProfileScreen ({Key? key}) : super (key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen>{
  
  @override
  Widget build(BuildContext  context){
    
    return Scaffold(

      // appBar: AppBar(
      //   /*
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios),
      //     onPressed: (){
      //       Navigator.pop(context);
      //     },
      //   ),
      //   */
      //   title: SubtitleText(
      //       text: S.current.Account,
      //       fontWeight: FontWeight.w500
      //   ),
      //   centerTitle: true,
      // ),

      body: SafeArea(
        child: Column(
          children: [
            SubtitleText(
                text: S.current.Account,
                fontWeight: FontWeight.w500
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Center(
                child: Card(
                  elevation: 10,
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

            /*
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Center(
                child: Card(
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // if you need this
                    side: BorderSide(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
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
                )
              ),
            ),
            */

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [

                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero), // Establece el padding a cero
                    ),
                    onPressed: () {}, 
                    child: ListTile(
                      leading: Icon(Icons.person_2_outlined),
                      title: Text('Edit profile'),
                    )
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero), // Establece el padding a cero
                    ),
                    onPressed: () {}, 
                    child: ListTile(
                      leading: Icon(Icons.phone_android),
                      title: Text('Linked devices'),
                    )
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero), // Establece el padding a cero
                    ),
                    onPressed: () {}, 
                    child: ListTile(
                      leading: Icon(Icons.wb_sunny_outlined),
                      title: Text('Appearance'),
                    )
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero), // Establece el padding a cero
                    ),

                    onPressed: () {
                      showModalBottomSheet (
                        context: context,
                        builder: (context) {
                          return SwitchBottomSheet();
                        },
                      );
                    },

                    child: ListTile(
                      leading: Icon(Icons.public_outlined),
                      title: Text('Language'),
                    )
                  ),


                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero), // Establece el padding a cero
                    ),
                    onPressed: () {}, 
                    child: ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('Notifications'),
                    )
                  ),
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero), // Establece el padding a cero
                    ),
                    onPressed: () {}, 
                    child: ListTile(
                      leading: Icon(Icons.bug_report_outlined),
                      title: Text('Report an error'),
                    )
                  ),
                  SizedBox(height: 90),
                  BaseElevatedButton(
                    text: S.current.LoginButton,
                    onPressed: () {
                    }
                  )
                ],
              ),
            ),
            
            /*
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Positioned(
                bottom: -420,
                left: 0,
                right: 0,
                child: BaseElevatedButton(
                    text: S.current.Login,
                    onPressed: (){}
                )
              ),
            ),
            */
          ],
        )
      ),
    );
  }
}