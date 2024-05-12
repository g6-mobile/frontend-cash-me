import 'package:flutter/material.dart';
// import 'package:pocket_swap_fisi/screen/auth/email_verification_screen.dart';
// import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart';
// import 'package:pocket_swap_fisi/widget/text_field.dart';
import '../../generated/l10n.dart';

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
        child: Center(
          child: Column(
            children: [
              Text(
                'dfdxfgdgd'
              )
            ],
          ),
        ),
      ),
    );
  }
}