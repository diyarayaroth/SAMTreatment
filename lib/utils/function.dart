import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class CommonFunctions {
  static void toast(String info) {
    Fluttertoast.showToast(
      timeInSecForIosWeb: 1,
      msg: info,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT, // Change the toast length to SHORT
    );
  }

  static Future<bool> checkConnectivity() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        CommonFunctions.toast(
            "please check you mobile data or wifi connection!");
        return false;
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          CommonFunctions.toast(
              "please check you mobile data or wifi connection!");
          return false;
        }
      }
    } on SocketException catch (_) {
      CommonFunctions.toast("please check you mobile data or wifi connection!");
      return false;
    }
  }

  // check location permission and get current location
  // static Future<Position> getCurrentLocation() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       CommonFunctions.toast("Location permission denied");
  //       return Future.error("Location permission denied");
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     CommonFunctions.toast("Location permission denied forever");
  //     return Future.error("Location permission denied forever");
  //   }

  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   debugPrint("current Position: $position");
  //   return position;
  // }
}
