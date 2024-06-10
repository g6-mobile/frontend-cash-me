import 'package:dio/dio.dart';
import 'package:pocket_swap_fisi/domain/services/auth_service.dart';
import 'package:pocket_swap_fisi/domain/services/user_service.dart';
import 'package:pocket_swap_fisi/domain/usecases/auth_usecase.dart';
import 'package:pocket_swap_fisi/domain/usecases/user_usecase.dart';
import 'package:pocket_swap_fisi/providers/auth_provider.dart';
import 'package:pocket_swap_fisi/providers/user_provider.dart';
import 'package:provider/provider.dart';

final Dio dio = Dio();

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider(
    create: (_) => AuthProvider(AuthUseCase(AuthService())),
  ),
  ChangeNotifierProvider(
    create: (_) => UserProvider(UserUseCase(UserService(dio))),
  ),  
];