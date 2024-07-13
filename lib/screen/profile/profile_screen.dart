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

import '../../generated/l10n.dart';
import '../../providers/theme_provider.dart'; //S

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, child) {
      final user = authProvider.user;
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
                              child: Image.network(user.userPhoto ?? '',
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
                      child: ListTile(
                        leading: Icon(Icons.person_2_outlined),
                        title: Text(S.current.EditProfile),
                      )),
                  TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero), // Establece el padding a cero
                      ),
                      onPressed: () {},
                      child: ListTile(
                        leading: Icon(Icons.phone_android),
                        title: Text(S.current.LinkedDevices),
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
                            return const ThemeBottomSheet();
                          },
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.wb_sunny_outlined),
                        title: Text(S.current.Theme),
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
                            return const LanguagesBottomSheet();
                          },
                        );
                      },
                      child: ListTile(
                        leading: Icon(Icons.public_outlined),
                        title: Text(S.current.Language),
                      )),
                  TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero), // Establece el padding a cero
                      ),
                      onPressed: () {},
                      child: ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text(S.current.Notifications),
                      )),
                  TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero), // Establece el padding a cero
                      ),
                      onPressed: () {},
                      child: ListTile(
                        leading: Icon(Icons.bug_report_outlined),
                        title: Text(S.current.ReportAnError),
                      )),
                  const SizedBox(height: 90),
                  BaseElevatedButton(
                      isLoading: _isLoading,
                      text: S.current.SignOut,
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
          ],
        )),
      );
    });

  }
}

/*  */
class LanguagesBottomSheet extends StatefulWidget {
  const LanguagesBottomSheet({Key? key}) : super(key: key);
  @override
  _LanguagesBottomSheetState createState() => _LanguagesBottomSheetState();
}

class _LanguagesBottomSheetState extends State<LanguagesBottomSheet> {
  bool _isSwitched = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  _loadSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('languageCode') ?? WidgetsBinding.instance!.window.locale.languageCode;
    setState(() {
      _isSwitched = languageCode == 'es';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
        crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
        children: [
          Image.asset(
            _isSwitched
                ? 'assets/images/peru_spanish.png'
                : 'assets/images/eeuu_english.png',
            width: 140,
            height: 140,
          ),

          const SizedBox(height: 40),
          LanguageSwitch(
            isSpanish: _isSwitched,
            onToggle: (bool value) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                _isSwitched = value;
                if (_isSwitched) {
                  S.load(Locale('es', 'ES')); // Cargar español
                  prefs.setString('languageCode', 'es'); // Guardar el código de idioma como un String
                } else {
                  S.load(Locale('en', '')); // Cargar inglés
                  prefs.setString('languageCode', 'en'); // Guardar el código de idioma como un String
                };
              });
            },
          ),
        ],
      ),
    );
  }
}

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({Key? key}) : super(key: key);

  @override
  _ThemeBottomSheetState createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemeState();
  }

  _loadThemeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = (prefs.getBool('isDarkMode') ?? false);
    });
  }

  _saveThemeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Centra verticalmente
        crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente
        children: [
          Image.asset(
            _isDarkMode
                ? 'assets/images/dark_mode.png'
                : 'assets/images/light_mode.png',
            width: 140,
            height: 140,
          ),
          const SizedBox(height: 40),
          ThemeSwitch(
            isDarkMode: _isDarkMode,
            onToggle: (bool value) {
              setState(() {
                _isDarkMode = value;
                _saveThemeState();
                // Change the theme of the app
                if (_isDarkMode) {
                  Provider.of<ThemeProvider>(context, listen: false).themeMode = ThemeMode.dark;
                } else {
                  Provider.of<ThemeProvider>(context, listen: false).themeMode = ThemeMode.light;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}

class LanguageSwitch extends StatelessWidget {
  final bool isSpanish;
  final Function(bool) onToggle;

  LanguageSwitch({required this.isSpanish, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onToggle(!isSpanish);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.grey[300],
        ),
        child: Stack(
          children: [
            Positioned(
              left: isSpanish ? 160 : 10,
              top: 5,
              bottom: 5,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 150,
                alignment: Alignment.center,
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                  child: Text(S.current.English),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 150,
                alignment: Alignment.center,
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                  child: Text(S.current.Spanish),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeSwitch extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onToggle;

  ThemeSwitch({required this.isDarkMode, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onToggle(!isDarkMode);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: 60,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
        ),
        child: Stack(
          children: [
            Positioned(
              left: isDarkMode ? 160 : 10,
              top: 5,
              bottom: 5,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: isDarkMode ? Colors.black : Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 150,
                alignment: Alignment.center,
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                  child: Text(S.current.LightTheme),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 150,
                alignment: Alignment.center,
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                  ),
                  child: Text(S.current.DarkTheme),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

