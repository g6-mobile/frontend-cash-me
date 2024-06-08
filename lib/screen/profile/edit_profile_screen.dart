import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:pocket_swap_fisi/providers/auth_provider.dart';
//import 'package:pocket_swap_fisi/screen/auth/login_screen.dart';
//import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
import 'package:pocket_swap_fisi/widget/text_field.dart';
//import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shimmer/shimmer.dart';

import '../../generated/l10n.dart'; //S



class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
          children: [
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  Container(
                    child: ClipOval(
                      // child: Image.network('src'),
                      child: Image.asset(
                        'assets/images/img_profile_user.png',
                        width: 130,
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
            Center(
              child: Text(
                'Diego Zavala',
                style: TextStyle(
                  fontSize: 19.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF762B2B),
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            /*
            BaseTextField(
              hintText: S.current.HintEmail,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            */
          ],
        ),
      ),
    );

  }
}



/*
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    authProvider.loadUser();
    final user = authProvider.user;
    return Scaffold(
      appBar: AppBar(
        title:
            SubtitleText(text: S.current.Account, fontWeight: FontWeight.w500),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Center(
              child: Card(
                elevation: 5,
                child: user != null
                    ? ListTile(
                        leading: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 44,
                            minHeight: 44,
                            maxWidth: 64,
                            maxHeight: 64,
                          ),
                          child: ClipOval(
                            child: Image.network(user.userPhoto,
                                fit: BoxFit.cover),
                          ),
                        ),
                        title: Text(
                          '${user.firstName} ${user.lastName}',
                          style: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${user.major}\n#${user.studentCode}'),
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: ListTile(
                          leading: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 44,
                              minHeight: 44,
                              maxWidth: 64,
                              maxHeight: 64,
                            ),
                            child: ClipOval(
                              child: Container(
                                width: 54,
                                height: 64,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 210,
                                height: 30,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: 210,
                                height: 20,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
      
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero), // Establece el padding a cero
                    ),
                    onPressed: () {},
                    child: const ListTile(
                      leading: Icon(Icons.person_2_outlined),
                      title: Text('Edit profile'),
                    )),
                TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero), // Establece el padding a cero
                    ),
                    onPressed: () {},
                    child: const ListTile(
                      leading: Icon(Icons.phone_android),
                      title: Text('Linked devices'),
                    )),
                TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero), // Establece el padding a cero
                    ),
                    onPressed: () {},
                    child: const ListTile(
                      leading: Icon(Icons.wb_sunny_outlined),
                      title: Text('Appearance'),
                    )),
                TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero), // Establece el padding a cero
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const SwitchBottomSheet();
                        },
                      );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.public_outlined),
                      title: Text('Language'),
                    )),
                TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero), // Establece el padding a cero
                    ),
                    onPressed: () {},
                    child: const ListTile(
                      leading: Icon(Icons.notifications),
                      title: Text('Notifications'),
                    )),
                TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.zero), // Establece el padding a cero
                    ),
                    onPressed: () {},
                    child: const ListTile(
                      leading: Icon(Icons.bug_report_outlined),
                      title: Text('Report an error'),
                    )),
                const SizedBox(height: 90),
                BaseElevatedButton(
                    isLoading: _isLoading,
                    text: "Cerrar sesión",
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        await authProvider.logout();
                      } catch (e) {
                        print('Error: $e');
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    })
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
      )),
    );
  }
}


/*  */
class SwitchBottomSheet extends StatefulWidget {
  const SwitchBottomSheet({Key? key}) : super(key: key);
  @override
  _SwitchBottomSheetState createState() => _SwitchBottomSheetState();
}

class _SwitchBottomSheetState extends State<SwitchBottomSheet> {
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isSwitched = prefs.getBool('switchState') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
        crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            _isSwitched
                ? 'assets/images/eeuu_english.png'
                : 'assets/images/peru_spanish.png',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 10),
          Text(_isSwitched ? 'English' : 'Español'),
          const SizedBox(height: 2),
          CupertinoSwitch(
            value: _isSwitched,
            activeColor: const Color.fromARGB(255, 217, 217, 217),
            onChanged: (bool value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                _isSwitched = value;
                prefs.setBool('switchState', value);
              });
            },
          ),
        ],
      ),
    );
  }
}
*/