import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pocket_swap_fisi/domain/services/auth_service.dart';
import 'package:pocket_swap_fisi/domain/usecases/auth_usecase.dart';
import 'package:pocket_swap_fisi/screen/auth/login_screen.dart';
import 'package:pocket_swap_fisi/screen/home/home_screen.dart';
import 'package:pocket_swap_fisi/screen/register/register_screen.dart';
import 'package:pocket_swap_fisi/theme/dark_theme.dart';
import 'package:pocket_swap_fisi/theme/light_theme.dart';
import 'package:pocket_swap_fisi/utils/constants/api_constants.dart';

import 'generated/l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Dio dio = Dio();
  late AuthService _authService;
  late AuthUseCase _authUseCase;

  @override
  Widget build(BuildContext context) {
    dio.options.baseUrl = ApiConstants.baseURL;

    _authService = AuthService(dio);
    _authUseCase = AuthUseCase(_authService);

    return MaterialApp(
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
      home: FutureBuilder<String?>(
        future: _authService.getToken(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Muestra un indicador de carga mientras se obtiene el token
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              return HomeScreen(); // Si el token existe, redirige a la pantalla principal
            } else {
              return LoginScreen(
                  authUseCase:
                      _authUseCase); // Si el token no existe, redirige a la pantalla de inicio de sesión
            }
          }
        },
      ),
    );
  }
}
