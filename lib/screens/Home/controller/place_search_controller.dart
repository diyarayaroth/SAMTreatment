// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_webservice/places.dart';

// class PlaceSearchController extends GetxController {
//   final GoogleMapsPlaces _places =
//       GoogleMapsPlaces(apiKey: "AIzaSyBzn3ryihAgBbqcZbmyzMe894DgH_TeV4w");
//   var predictions = <Prediction>[].obs;

//   Future<void> getPredictions(String input) async {
//     if (input.isEmpty) {
//       predictions.clear();
//       return;
//     }
//     PlacesAutocompleteResponse response = await _places.autocomplete(input);
//     if (response.isOkay) {
//       predictions.value = response.predictions;
//     } else {
//       print(response.errorMessage);
//     }
//   }

//   Future<PlacesDetailsResponse> getPlaceDetails(String placeId) async {
//     PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);
//     if (detail.isOkay) {
//       debugPrint("Place details: ${detail.result.name}");
//       debugPrint("Place details: ${detail.result.formattedAddress}");
//       debugPrint("Place details lat : ${detail.result.geometry?.location.lat}");
//       debugPrint("Place details lng: ${detail.result.geometry?.location.lng}");
//       debugPrint("Place details lng: ${detail.result.formattedAddress}");
//       log("Place details list: ${jsonEncode(detail)}");
//       String getPostalCode(PlacesDetailsResponse detail) {
//         for (var component in detail.result.addressComponents) {
//           if (component.types.contains('postal_code')) {
//             log(component.longName, name: 'Postal code here');
//             return component.longName;
//           }
//         }
//         return 'Postal code not found';
//       }

//       return detail;
//     } else {
//       throw Exception('Failed to fetch place details');
//     }
//   }
// }

import 'dart:convert';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';

class PlaceSearchController extends GetxController {
  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: "AIzaSyBzn3ryihAgBbqcZbmyzMe894DgH_TeV4w");
  var predictions = <Prediction>[].obs;
  RxString address = ''.obs;

  Future<void> getPredictions(String input) async {
    if (input.isEmpty) {
      predictions.clear();
      return;
    }
    PlacesAutocompleteResponse response = await _places.autocomplete(input);
    if (response.isOkay) {
      predictions.value = response.predictions;
    } else {
      print(response.errorMessage);
    }
  }

  Future<PlacesDetailsResponse> getPlaceDetails(String placeId) async {
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);
    if (detail.isOkay) {
      log("Place details: ${jsonEncode(detail)}");
      address.value = detail.result.formattedAddress ?? "";

      return detail;
    } else {
      throw Exception('Failed to fetch place details');
    }
  }

  Future<String> getPostalCode(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      for (var placemark in placemarks) {
        if (placemark.postalCode != null) {
          return placemark.postalCode!;
        }
      }
      return 'Postal code not found';
    } catch (e) {
      return 'Error fetching postal code';
    }
  }
}
