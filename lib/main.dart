import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_swap_fisi/screen/auth/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pocket_swap_fisi/theme/dark_theme.dart';
import 'package:pocket_swap_fisi/theme/light_theme.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const LoginScreen(),
    );
  }
}