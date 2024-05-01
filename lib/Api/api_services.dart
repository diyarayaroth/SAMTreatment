import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Api {
  final http.Client client;
  Api(this.client);

  //Submit Complied ByOwner
  static Future getDoctorListApi(apiUrl) async {
    // String url = "${getDoctorListApi}/${apiUrl}";
    debugPrint("getDoctorListApi URL: ");
    return http.get(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'}).then((response) {
      debugPrint('getDoctorListApi statusCode ===>${response.statusCode}');
      debugPrint('getDoctorListApi body ===>${response.body}');
      return response.statusCode == 200
          ? jsonDecode(response.body)
          : jsonDecode(response.body);
    }).catchError((err) => debugPrint("getDoctorListApi======>$err"));
  }
}
