import 'package:dio/dio.dart';
import 'package:pocket_swap_fisi/utils/interceptors/dio_interceptor.dart';

Dio createDio() {
  final dio = Dio();
  dio.interceptors.add(DioInterceptor());
  return dio;
}
