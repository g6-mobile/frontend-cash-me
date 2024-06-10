import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pocket_swap_fisi/utils/constants/api_constants.dart';

class DioInterceptor extends Interceptor {
  Dio dio = Dio();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      "Content-Type": "application/json",
      "Accept": "*/*",
    });

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        await refreshToken();
        handler.resolve(await _retry(err.requestOptions));
      } on TokenExpiredException {
        // appRouter.pushAndPopUntil(LoginRoute(onResult: (result) {}),
        //     predicate: (route) => false);
        handler.reject(err);
      } on DioException catch (e) {
        handler.next(e);
      }
      return;
    }
    handler.next(err);
  }

  Future<void> refreshToken() async {
    const storage = FlutterSecureStorage();
    final refreshToken = await storage.read(key: 'refreshToken');
    try {
      final response = await dio.get('${ApiConstants.baseURL}/auth/refresh',
          options: Options(headers: {'Authorization': 'Bearer $refreshToken'}));

      if (response.statusCode != 200) {
        throw Exception('Failed to refresh token');
      }

      final data = response.data['data'];

      await storage.write(key: 'accessToken', value: data['accessToken']);
      await storage.write(key: 'refreshToken', value: data['refreshToken']);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await storage.deleteAll();
        TokenExpiredException();
      }
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'accessToken');
    if (token == null) {
      throw TokenExpiredException();
    }
    final options = Options(
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}

class TokenExpiredException implements Exception {}
