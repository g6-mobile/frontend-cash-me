import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:pocket_swap_fisi/screen/auth/login_screen.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
import 'package:provider/provider.dart';
import '../../generated/l10n.dart'; //S
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {  
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);    
    return Scaffold(
      appBar: AppBar(
        /*
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        */
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
              child: Card.outlined(
                child: ListTile(
                  leading: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 44,
                      minHeight: 44,
                      maxWidth: 64,
                      maxHeight: 64,
                    ),
                    child: Image.asset('assets/images/img_profile_user.png',
                        fit: BoxFit.cover),
                  ),
                  title: const Text(
                    'Diego Chavala',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Ing. de Software\n#20203513'),
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
                    text: S.current.LoginButton,
                    onPressed: () async {
                      const storage = FlutterSecureStorage();
                      final accessToken = await storage.read(key: 'accessToken');
                      await authProvider.logout(accessToken);

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
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
