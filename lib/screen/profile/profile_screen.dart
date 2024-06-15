import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:pocket_swap_fisi/routes/app_router.gr.dart';
import 'package:pocket_swap_fisi/widget/button.dart';
import 'package:pocket_swap_fisi/widget/text.dart'; //subtittleText
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../generated/l10n.dart'; //S

@RoutePage()
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
                    onPressed: () {
                      AutoRouter.of(context).push(const EditProfileRoute());
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
                    },
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
                        //Uncomment this line to solve the context warning
                        // if (!context.mounted) return;

                        AutoRouter.of(context)
                            .replace(LoginRoute(onResult: (result) {}));
                      } catch (e) {
                        print('Error: $e');
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
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
