import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:product_hunt_app/providers/base/provider_helpers.dart';
import 'package:product_hunt_app/providers/base/provider_response.dart';
import 'package:product_hunt_app/services/api_service/rest_client.dart';
import 'package:product_hunt_app/utils/app_constants.dart';
import 'package:product_hunt_app/utils/app_enums.dart';
import 'package:product_hunt_app/utils/app_keys.dart';

class ApiServices extends RestClient {
  static ApiServices _apiServices;

  ApiServices._internal();
  factory ApiServices() {
    _apiServices = _apiServices ?? ApiServices._internal();
    return _apiServices;
  }

  /// common interface for all api requests
  Future<ProviderResponse> apiRequest(
      ApiRequestType request, ProviderEvent event, String apiEndPoint,
      {Map<String, dynamic> body,
      bool authHeader = false,
      bool isCsv = false,
      ApiContentType contentType = ApiContentType.json,
      Map<String, dynamic> queryParams,
      Duration timeoutDuration}) async {
    Uri uri = createURL(request, apiEndPoint, queryParams);
    Map<String, String> headers =
        await getHeaders(authHeader, contentType, isCsv: isCsv);

    if (kDebugMode) {
      log('------------------------------------------');
      final startTime = DateTime.now();
      log('START TIME: ${startTime.hour} : ${startTime.minute} : ${startTime.second}');
      log('URL: $uri');
      log('METHOD: ${request == ApiRequestType.apiPost ? 'POST' : 'GET'}');
      log('HEADERS: $headers');
      log('BODY: $body');
    }

    // try api requests
    try {
      int statusCode;
      String responseBody;

      // multipart form-data request
      if (contentType == ApiContentType.formData) {
        http.StreamedResponse response =
            await formDataRequest(uri, request, headers, body);
        statusCode = response.statusCode;
        if (response.stream == null) {
          responseBody = '{}';
        } else {
          List<String> dataList = await Future.wait(await response.stream
              .map((bytes) async =>
                  await http.ByteStream.fromBytes(bytes).bytesToString())
              .toList());
          responseBody = '';
          dataList.forEach((data) => responseBody += data);
        }
      } else {
        http.Response response;
        switch (request) {
          case ApiRequestType.apiGet:
            response = await getRequest(uri, headers);
            break;
          case ApiRequestType.apiPost:
            response = await postRequest(uri, headers, body ?? {},
                timeoutDuration: timeoutDuration);
            break;
          case ApiRequestType.apiDelete:
            response = await deleteRequest(uri, headers, body ?? {});
            break;
          case ApiRequestType.apiPatch:
            response = await patchRequest(uri, headers, body ?? {});
            break;
          default:
            return ProviderResponse(
              ProviderState.failed,
              event,
              message: "Error",
            );
        }
        statusCode = response.statusCode;
        responseBody = response.body;
      }

      if (kDebugMode) {
        log('STATUS CODE: $statusCode');
        log('RESPONSE: $responseBody');
      }

      var res = isCsv ? responseBody : jsonDecode(responseBody);
      bool isSuccess = false;
      if (res is Map) {
        if ((res[ApiKeys.errorNo] == null ||
            res[ApiKeys.errorNo] == 0 ||
            (event == ProviderEvent.generateAccessToken &&
                res[ApiKeys.errorNo] == 999))) {
          if (AppRegex.successCode.hasMatch('$statusCode')) {
            isSuccess = true;
          }
        }
      } else {
        if (AppRegex.successCode.hasMatch('$statusCode')) {
          isSuccess = true;
        }
      }

      if (isSuccess) {
        return ProviderResponse(
          ProviderState.success,
          event,
          data: res,
          statusCode: statusCode,
        );
      } else {
        return ProviderResponse(
          ProviderState.failed,
          event,
          message: res is String ? res : res[ApiKeys.message],
          data: res,
          statusCode: statusCode,
        );
      }
    } on SocketException {
      return ProviderResponse(
        ProviderState.noInternet,
        event,
        message: "No Internet",
      );
    } on TimeoutException {
      return ProviderResponse(
        ProviderState.noInternet,
        event,
        message: "Timeout error",
      );
    } catch (e) {
      return ProviderResponse(
        ProviderState.failed,
        event,
        message: e.toString(),
        exceptionType: e.runtimeType,
      );
    } finally {
      if (kDebugMode) {
        final endTime = DateTime.now();
        log('END TIME: ${endTime.hour} : ${endTime.minute} : ${endTime.second}');
        log('---------------------------------------');
      }
    }
  }
}
