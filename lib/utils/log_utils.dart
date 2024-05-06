import 'dart:developer';
import 'package:flutter/foundation.dart';

class LogUtils {
  static showLogs({String? tag, String? message}) {
    if (!kReleaseMode) {
      log(message!, name: tag!);
    }
  }

  static showPrint(String message) {
    if (!kReleaseMode) {
      debugPrint(message);
    }
  }

  static showErrorLogs({String? tag, String? message, String? error}) {
    if (!kReleaseMode) {
      log(message!, name: tag!, error: error);
    }
  }
}
