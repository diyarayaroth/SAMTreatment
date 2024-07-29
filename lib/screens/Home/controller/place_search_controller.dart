// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/constant.dart';

class PlaceSearchController extends GetxController {
  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: AppConst.googleApiKey);
  var predictions = <Prediction>[].obs;
  RxString address = ''.obs;

//  getPredictions function use for search places prediction
  Future<void> getPredictions(String input) async {
    if (input.isEmpty) {
      predictions.clear();
      return;
    }
    PlacesAutocompleteResponse response = await _places.autocomplete(input);
    if (response.isOkay) {
      predictions.value = response.predictions;
      debugPrint("address value 11 == ${response.predictions}");
    } else {
      debugPrint(response.errorMessage);
    }
  }

  // getPlaceDetails function use for get place details
  Future<PlacesDetailsResponse> getPlaceDetails(String placeId) async {
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);
    if (detail.isOkay) {
      address.value = detail.result.formattedAddress ?? "";
      debugPrint("address value == $address");

      return detail;
    } else {
      throw Exception(AppStrings.failedToFetch);
    }
  }

// getPostalCode function use for get postal code from lat and long
  Future<String> getPostalCode(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      for (var placemark in placemarks) {
        if (placemark.postalCode != null) {
          return placemark.postalCode!;
        }
      }
      return AppStrings.postalCodenotfound;
    } catch (e) {
      return AppStrings.errorFetchingpostalcode;
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:health_care/utils/app_string.dart';
// import 'package:health_care/utils/constant.dart';

// class PlaceSearchController extends GetxController {
//   final GoogleMapsPlaces _places =
//       GoogleMapsPlaces(apiKey: AppConst.googleApiKey);
//   var predictions = <Prediction>[].obs;
//   RxString address = ''.obs;
//   RxString city = ''.obs;
//   RxString postalCode = ''.obs;

//   // getPredictions function use for search places prediction
//   Future<void> getPredictions(String input) async {
//     if (input.isEmpty) {
//       predictions.clear();
//       return;
//     }
//     PlacesAutocompleteResponse response = await _places.autocomplete(input);
//     if (response.isOkay) {
//       predictions.value = response.predictions;
//       debugPrint("Predictions: ${response.predictions}");
//     } else {
//       debugPrint(response.errorMessage);
//     }
//   }

//  // getPlaceDetails function use for get place details
// Future<PlacesDetailsResponse> getPlaceDetails(String placeId) async {
//   PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);
//   if (detail.isOkay) {
//    // address.value = detail.result.formattedAddress ?? "";

//     double lat = detail.result.geometry!.location.lat;
//     double lng = detail.result.geometry!.location.lng;

//     List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
//     if (placemarks.isNotEmpty) {
//       city.value = placemarks[0].locality ?? "";
//       postalCode.value = placemarks[0].postalCode ?? "";
//     }
//     return detail; // Return the detail object
//   } else {
//     throw Exception(AppStrings.failedToFetch);
//   }
// }

//   // getPostalCode function use for get postal code from lat and long
//   Future<String> getPostalCode(double lat, double lng) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
//       for (var placemark in placemarks) {
//         if (placemark.postalCode != null) {
//           return placemark.postalCode!;
//         }
//       }
//       return AppStrings.postalCodenotfound;
//     } catch (e) {
//       return AppStrings.errorFetchingpostalcode;
//     }
//   }
// }

