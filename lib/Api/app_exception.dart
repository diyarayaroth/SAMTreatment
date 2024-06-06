// ignore_for_file: prefer_interpolation_to_compose_strings, unused_catch_stack, prefer_adjacent_string_concatenation
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class AppException implements Exception {
  String message;
  String? tag;
  int errorCode;
  AppException({required this.message, required this.errorCode, this.tag});
  @override
  String toString() {
    return message;
  }

  static AppException decodeExceptionData({required String jsonString}) {
    AppException exception;
    try {
      dynamic decodedData = jsonDecode(jsonString);
      exception = AppException(
          message: decodedData['message'], errorCode: decodedData['errorCode']);
    } catch (e, stacktrace) {
      exception = AppException(
        message: "Unable to communicate with the server at the moment." +
            '\n\n' +
            "Please try again later",
        errorCode: 105,
      );
    }
    return exception;
  }

  static dynamic exceptionHandler(exception, [stackTrace]) {
    debugPrint('Exception Message ==> ${exception ?? 'no message'}');
    if (exception is AppException) {
      throw exception;
    } else if (exception is SocketException) {
      debugPrint(stackTrace ?? "No stack provided");
      throw AppException(
        message: "Internet not available."
            '\n'
            "Cross check your internet connectivity and try again later.",
        errorCode: 101,
      );
    } else if (exception is TimeoutException) {
      debugPrint(stackTrace ?? "No stack provided");
      throw AppException(
        message: "The request has timed out." +
            r'''\n''' +
            "The network seems to be very slow," r'''\n\n''' +
            "Please try again!!!",
        errorCode: 102,
      );
    } else if (exception is HttpException) {
      debugPrint(stackTrace ?? "No stack provided");
      throw AppException(
          message: "Couldn't find the requested data", errorCode: 103);
    } else if (exception is FormatException) {
      debugPrint(stackTrace ?? "No stack provided");
      throw AppException(
        message: "Looks like our server is down for maintenance," +
            r'''\n\n''' +
            "Please try again later.",
        errorCode: 104,
      );
    }
    debugPrint(stackTrace ?? "No stack provided");
    throw AppException(
      message: "Unable to communicate with the server at the moment." +
          r'''\n\n''' +
          "Please try again later",
      errorCode: 105,
    );
  }
}
