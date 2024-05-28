import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pocket_swap_fisi/domain/services/auth_service.dart';
import 'package:pocket_swap_fisi/domain/services/user_service.dart';
import 'package:pocket_swap_fisi/domain/usecases/auth_usecase.dart';
import 'package:pocket_swap_fisi/domain/usecases/user_usecase.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:pocket_swap_fisi/providers/user_provider.dart';
import 'package:pocket_swap_fisi/screen/splash_screen.dart';
import 'package:pocket_swap_fisi/theme/dark_theme.dart';
import 'package:pocket_swap_fisi/theme/light_theme.dart';
import 'package:pocket_swap_fisi/utils/constants/api_constants.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    dio.options.baseUrl = ApiConstants.baseURL;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(AuthUseCase(AuthService(dio))),
          ),
          ChangeNotifierProvider(
            create: (_) => UserProvider(AuthUseCase(AuthService(dio)),UserUseCase(UserService(dio))),
          ),          
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          title: 'Flutter Demo',
          theme: lightTheme,
          darkTheme: darkTheme,
          home: const SplashScreen(),
        ));
  }
}
