

import 'dart:async';
import 'dart:io';
import '../../commundomain/api_result_model.dart';
import '../../commundomain/error_result_model.dart';
import '../constants/app_constants.dart';
import 'connectivity_checker_helper.dart';
import 'package:http/http.dart' as http;

class ApiCallHelper{
  ApiCallHelper(this.connectivityCheckerHelper);

  final ConnectivityCheckerHelper connectivityCheckerHelper;
  final String? baseUrl = devBaseUrl;

  Map<String, String> _sharedDefaultHeader = <String, String>{};

  Future<void> initSharedDefaultHeader(
      [String contentValue = contentTypeValue]) async {
    _sharedDefaultHeader = <String, String>{};
    _sharedDefaultHeader.addAll(<String, String>{
      contentTypeKey: contentValue,
    });
  }


  Future<bool> _getConnectionState() async {
    final bool _result = await connectivityCheckerHelper.checkConnectivity();
    return _result;
  }

  Future<ApiResultModel<http.Response>> getWS({
    required String uri,
    Map<String, String> headers = const <String, String>{},
    Map<String, dynamic> params = const <String, dynamic>{},
  }) async {
    await initSharedDefaultHeader();
    _sharedDefaultHeader.addAll(headers);
    if (await _getConnectionState()) {
      try {
        final String _url = '$baseUrl$uri';
        final http.Response response = await http
            .get(_url.parseUri(params: params), headers: _sharedDefaultHeader)
            .timeout(timeOutDuration);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return ApiResultModel<http.Response>.success(data: response);
        } else {
          return ApiResultModel<http.Response>.failure(
            errorResultEntity: ErrorResultModel(
              message: response.reasonPhrase,
              statusCode: response.statusCode,
            ),
          );
        }
      } on TimeoutException catch (_) {
        return const ApiResultModel<http.Response>.failure(
          errorResultEntity: ErrorResultModel(
            message: commonErrorUnexpectedMessage,
            statusCode: timeoutRequestStatusCode,
          ),
        );
      } on IOException catch (_) {
        throw CustomConnectionException(
          exceptionMessage: commonConnectionFailedMessage,
          exceptionCode: ioExceptionStatusCode,
        );
      }
    } else {
      throw CustomConnectionException(
        exceptionMessage: commonConnectionFailedMessage,
        exceptionCode: ioExceptionStatusCode,
      );
    }
  }
}