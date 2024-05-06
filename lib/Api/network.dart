// ignore_for_file: prefer_if_null_operators, dead_code, prefer_interpolation_to_compose_strings, constant_identifier_names, empty_catches, prefer_adjacent_string_concatenation
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:health_care/Api/app_exception.dart';
import 'package:health_care/constants/baseurl.dart';
import 'package:health_care/utils/log_utils.dart';
import 'package:http/http.dart' as http;

//This Class is not complete, under modification
const API_TIME_OUT = 120; //in seconds

class NetworkAPICall {
  static final NetworkAPICall _networkAPICall = NetworkAPICall._internal();
  factory NetworkAPICall() {
    return _networkAPICall;
  }
  NetworkAPICall._internal();
  Future<dynamic> post(String url, dynamic body,
      {bool isBaseUrl = true, Map<String, String>? headers}) async {
    var client = http.Client();
    try {
      // late String fullURL;
      late Map<String, String> header;
      // fullURL = isBaseUrl ? BASE_URL + url : url;
      header = headers == null ? {} : headers;
      LogUtils.showLogs(message: url, tag: 'API Url');
      LogUtils.showLogs(message: '$header', tag: 'API header');
      LogUtils.showLogs(message: '$body', tag: 'API body');
      var uri = Uri.parse(url);
      var response = await http
          .post(uri, body: body, headers: header)
          .timeout(const Duration(seconds: API_TIME_OUT));
      return checkResponse(response);
    } catch (exception) {
      client.close();
      throw AppException.exceptionHandler(exception);
    }
  }

  Future<dynamic> get(String url,
      {bool useBaseUrl = true,
      http.Client? apiClient,
      bool isDelete = false}) async {
    var client = http.Client();
    if (apiClient != null) {
      client = apiClient;
    }
    try {
      Map<String, String> header = {
        'Authorization': 'Bearer',
        //'Content-Type': "application/x-www-form-urlencoded"
      };
      LogUtils.showLogs(message: url, tag: 'API Url');
      // LogUtils.showLogs(message: '$header', tag: 'API header');
      var uri = Uri.parse(url);
      var response = isDelete
          ? await client
              .delete(uri, headers: header)
              .timeout(const Duration(seconds: API_TIME_OUT))
          : await client
              .get(uri, headers: header)
              .timeout(const Duration(seconds: API_TIME_OUT));
      // LogUtils.showLogs(message: response.body, tag: 'Response Body');
      LogUtils.showLogs(
          message: response.statusCode.toString(), tag: 'Response statusCode');
      return checkResponse(response);
    } catch (exception) {
      client.close();
      //  throw AppException.exceptionHandler(exception);
    }
  }

  Future<dynamic> getWithHeader(String url, Map<String, String>? header) async {
    final client = http.Client();
    try {
      String fullURL = baseUrl + url;
      LogUtils.showLogs(message: fullURL, tag: 'API Url');
      LogUtils.showLogs(message: '$header', tag: 'API header');
      var uri = Uri.parse(fullURL);
      var response = await client
          .get(uri, headers: header == null ? {} : header)
          .timeout(const Duration(seconds: API_TIME_OUT));
      // LogUtils.showLogs(message: response.body, tag: 'Response Body');
      LogUtils.showLogs(
          message: response.statusCode.toString(), tag: 'Response statusCode');
      return checkResponse(response);
    } catch (exception) {
      client.close();
      throw AppException.exceptionHandler(exception);
    }
  }

  /*
  // commented because getWithHEader method already there
  Future<dynamic> getWithHeader(String url, Map<String, String>? header) async {
    final client = http.Client();
    try {
      String fullURL = BASE_URL + url;
      LogUtils.showLogs(message: fullURL, tag: 'API Url');
      LogUtils.showLogs(message: '$header', tag: 'API header');
      var uri = Uri.parse(fullURL);
      var response = await client
          .get(uri, headers: header == null ? {} : header)
          .timeout(const Duration(seconds: 30));
      // LogUtils.showLogs(message: response.body, tag: 'Response Body');
      LogUtils.showLogs(
          message: response.statusCode.toString(), tag: 'Response statusCode');
      return checkResponse(response);
    } catch (exception) {
      client.close();
      throw AppException.exceptionHandler(exception);
    }
  }*/
  Future<dynamic> delete(String url) async {
    var client = http.Client();
    try {
      String fullURL = baseUrl + url;
      Map<String, String> header = {
        // 'Authorization': 'Bearer ',
        // 'Content-Type': 'application/json'
      };
      LogUtils.showLogs(message: fullURL, tag: 'API Url');
      LogUtils.showLogs(message: '$header', tag: 'API header');
      var uri = Uri.parse(fullURL);
      var response = await client.delete(uri, headers: header);
      LogUtils.showLogs(
          message: response.statusCode.toString(), tag: 'Response statusCode');
      return checkResponse(response);
    } catch (exception, stackTrace) {
      client.close();
      throw AppException.exceptionHandler(exception, stackTrace);
    }
  }

  Future<dynamic> multiPartPostRequest(
      String url, Map<String, String> body, File image) async {
    var client = http.Client();
    try {
      String fullURL = baseUrl + url;
      var header = {
        'Authorization': 'Bearer ',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      LogUtils.showLogs(message: fullURL, tag: 'API Url');
      var request = http.MultipartRequest('POST', Uri.parse(fullURL));
      request.fields.addAll(body);
      request.headers.addAll(header);
      request.files
          .add(await http.MultipartFile.fromPath('file', image.absolute.path));
      debugPrint("request.fields => ${request.fields}");
      http.StreamedResponse streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      debugPrint("Response code of Login API ==> ${response.statusCode}");
      if (response.statusCode == 200) {
        debugPrint(response.body);
        return checkResponse(response);
      } else {
        debugPrint(response.reasonPhrase);
      }
    } catch (exception) {
      client.close();
      rethrow;
    }
  }

  dynamic checkResponse(http.Response response) {
    try {
      LogUtils.showLogs(message: response.body.toString(), tag: 'API-RESPONSE');
      LogUtils.showLogs(
          message: response.statusCode.toString(), tag: 'API-STATUS-CODE');
    } catch (exception) {}
    switch (response.statusCode) {
      case 200:
        try {
          var json = jsonDecode(response.body);
          return json;
          if (json['success'] ?? false || json['status'] == "created") {
            return json;
          } else {
            throw AppException(
                message: json['message'], errorCode: json['status_code'] ?? 0);
          }
        } catch (e, stackTrace) {
          throw AppException.exceptionHandler(e, stackTrace);
        }
      case 201:
      case 400:
      case 401:
      case 500:
      case 502:
        throw AppException(
          message: "Looks like our server is down for maintenance," +
              r'''\n\n''' +
              "Please try again later.",
          errorCode: response.statusCode,
        );
      default:
        throw AppException(
            message: "Unable to communicate with the server at the moment." +
                r'''\n\n''' +
                "Please try again later",
            errorCode: response.statusCode);
    }
  }
}
