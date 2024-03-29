import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:product_hunt_app/utils/app_constants.dart';
import 'package:product_hunt_app/utils/app_enums.dart';
import 'package:product_hunt_app/utils/app_keys.dart';
import 'package:product_hunt_app/utils/global.dart';

class RestClient {
  Uri createURL(
    ApiRequestType request,
    String apiEndPoint,
    Map<String, dynamic> queryParams,
  ) {
    String url;
    url = AppBaseUrl.devBaseUrl + apiEndPoint;

    // append query params to url
    if (request == ApiRequestType.apiGet && queryParams != null) {
      int count = 0;
      queryParams.forEach((key, value) {
        if (count == 0) url += '?';
        url += '$key=$value';
        if (count < queryParams.length - 1) url += '&';
        count++;
      });
    }

    return Uri.parse(url);
  }

  /// return basic or auth headers
  Future<Map<String, String>> getHeaders(
      bool authHeader, ApiContentType contentType,
      {bool isCsv = false}) async {
    return {
      ApiKeys.contentType: (contentType == ApiContentType.json)
          ? ApiKeys.applicationJson
          : ApiKeys.formData,
      ApiKeys.authorization: "Bearer ${AppClientKeys.clientToken}"
    };
  }

  /// to send get api request
  Future<http.Response> getRequest(
    Uri uri,
    Map<String, String> headers,
  ) async {
    return await http
        .get(uri, headers: headers)
        .timeout(AppConstants.apiTimeOut);
  }

  /// to send get api request
  Future<http.Response> deleteRequest(
    Uri uri,
    Map<String, String> headersData,
    Map<String, dynamic> body,
  ) async {
    printDebug(
        '###################################################################');
    printDebug(
        '############Delete call#########################################');
    final client = http.Client();
    http.StreamedResponse response =
        await client.send(http.Request("DELETE", uri)
          ..headers.addAll(headersData)
          ..body = jsonEncode(body));
    return http.Response.fromStream(response).timeout(AppConstants.apiTimeOut);

    // return await http.Request(uri, headers: headers,).timeout(apiTimeOut);
  }

  /// to send post api request
  Future<http.Response> postRequest(
      Uri uri, Map<String, String> headers, Map<String, dynamic> body,
      {Duration timeoutDuration}) async {
    return await http
        .post(uri, headers: headers, body: json.encode(body))
        .timeout(timeoutDuration ?? AppConstants.apiTimeOut);
  }

  /// to send post api request
  Future<http.Response> patchRequest(
    Uri uri,
    Map<String, String> headers,
    Map<String, dynamic> body,
  ) async {
    return await http
        .patch(uri, headers: headers, body: json.encode(body))
        .timeout(AppConstants.apiTimeOut);
  }

  /// to send form-data
  Future<http.StreamedResponse> formDataRequest(
    Uri uri,
    ApiRequestType method,
    Map<String, String> headers,
    Map<String, dynamic> body,
  ) async {
    Map<String, dynamic> formData = await _fileConversion(body);
    http.MultipartRequest request = http.MultipartRequest(
        (method == ApiRequestType.apiPost)
            ? ApiKeys.postMethod
            : ApiKeys.getMethod,
        uri)
      ..fields.addAll(formData[ApiKeys.fields])
      ..files.addAll(formData[ApiKeys.files])
      ..headers.addAll(headers);
    http.StreamedResponse res =
        await request.send().timeout(AppConstants.apiTimeOut);
    return res;
  }

  /// to convert files to multipart-files for uploading
  Future<Map<String, dynamic>> _fileConversion(
    Map<String, dynamic> body,
  ) async {
    List<String> keysList = body.keys.toList();
    Map<String, String> fields = Map<String, String>();
    List<http.MultipartFile> files =
        List<http.MultipartFile>.empty(growable: true);

    for (var key in keysList) {
      if (body[key] is File) {
        files.add(await http.MultipartFile.fromPath(key, body[key].path));
      } else if (body[key] is List<File>) {
        for (var value in body[key]) {
          files.add(await http.MultipartFile.fromPath(key, value.path));
        }
      } else {
        fields[key] = body[key].toString();
      }
    }
    return {ApiKeys.fields: fields, ApiKeys.files: files};
  }
}
