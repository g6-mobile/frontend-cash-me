import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pocket_swap_fisi/domain/services/auth_service.dart';
import 'package:pocket_swap_fisi/domain/services/room_service.dart';
import 'package:pocket_swap_fisi/domain/services/user_service.dart';
import 'package:pocket_swap_fisi/domain/usecases/auth_usecase.dart';
import 'package:pocket_swap_fisi/domain/usecases/room_usecase.dart';
import 'package:pocket_swap_fisi/domain/usecases/user_usecase.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:pocket_swap_fisi/providers/message_provider.dart';
import 'package:pocket_swap_fisi/providers/room_provider.dart';
import 'package:pocket_swap_fisi/providers/theme_provider.dart';
import 'package:pocket_swap_fisi/providers/transaction_provider.dart';
import 'package:pocket_swap_fisi/providers/user_provider.dart';
import 'package:pocket_swap_fisi/routes/app_router.dart';
import 'package:pocket_swap_fisi/theme/dark_theme.dart';
import 'package:pocket_swap_fisi/theme/light_theme.dart';
import 'package:pocket_swap_fisi/utils/constants/api_constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/services/transaction_service.dart';
import 'domain/usecases/transaction_usecase.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String languageCode = await getLanguageCode();
  runApp(MyApp(languageCode: languageCode));
}

Future<String> getLanguageCode() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('languageCode') ??
      WidgetsBinding.instance.window.locale.languageCode;
}

class MyApp extends StatelessWidget {
  final String languageCode;

  MyApp({Key? key, required this.languageCode}) : super(key: key);

  final Dio dio = Dio();
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(AuthUseCase(AuthService())),
          ),
          ChangeNotifierProvider(
            create: (_) => UserProvider(UserUseCase(UserService())),
          ),
          ChangeNotifierProvider(
              create: (_) => TransactionProvider(
                  TransactionUseCase(TransactionService()))),
          ChangeNotifierProvider(create: (_) => MessageProvider()),
          ChangeNotifierProvider(
              create: (_) => RoomProvider(RoomUsecase(RoomService()))),
          ChangeNotifierProvider(
              create: (_) => ThemeProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp.router(
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              locale: Locale(languageCode, ''),
              // Set the locale
              supportedLocales: S.delegate.supportedLocales,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeProvider.themeMode,
              routerConfig: _appRouter.config(),
              builder: (context, child) {
                final isDarkMode =
                    MediaQuery.of(context).platformBrightness == Brightness.dark;

                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness:
                    isDarkMode ? Brightness.light : Brightness.dark,
                  ),
                  child: child!,
                );
              },
            );
          },
        ));
  }
}