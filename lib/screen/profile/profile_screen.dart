import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:pocket_swap_fisi/providers/user_provider.dart';
import 'package:pocket_swap_fisi/screen/auth/login_screen.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
import 'package:provider/provider.dart';
import '../../generated/l10n.dart'; //S
import 'package:pocket_swap_fisi/widget/bottom_sheet.dart';
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
    final userProvider = Provider.of<UserProvider>(context);
    userProvider.loadUser();
    final user = userProvider.user;
    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: SubtitleText(
              text: S.current.Account, fontWeight: FontWeight.w500),
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
                  child: ListTile(
                    leading: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: ClipOval(
                        child: Image.network(user.userPhoto, fit: BoxFit.cover),
                      ),
                    ),
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${user.major}\n#${user.studentCode}'),
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
                            return SwitchBottomSheet();
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
                      text: "Cerrar sesión",
                      onPressed: () async {
                        const storage = FlutterSecureStorage();
                        final accessToken =
                            await storage.read(key: 'accessToken');
                        await authProvider.logout(accessToken);

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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
