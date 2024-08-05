// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

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
    // print if input is integer
    if (int.tryParse(input) != null) {
      log("input is integer");

      PlacesAutocompleteResponse postalCodeResponse =
          await _places.autocomplete(
        input,
        types: ['postal_code'],
        components: [Component(Component.country, "us")],
        region: "us",
      );
      if (postalCodeResponse.isOkay) {
        predictions.value = postalCodeResponse.predictions;
        debugPrint(
            "postal code predictions == ${postalCodeResponse.predictions}");
      } else {
        debugPrint(postalCodeResponse.errorMessage);
      }
      PlacesAutocompleteResponse response = await _places.autocomplete(
        input,
        components: [Component(Component.country, "us")],
        region: "us",
      );
      debugPrint("address value 1 == $input");
      // debugPrint("address value 2 == $location");
      if (response.isOkay) {
        predictions.value = response.predictions;
        debugPrint("address value 11 == ${response.predictions}");
      } else {
        debugPrint(response.errorMessage);
      }
    } else {
      log("input is not integer");
      PlacesAutocompleteResponse response = await _places.autocomplete(
        input,
        components: [Component(Component.country, "us")],
        region: "us",
      );
      debugPrint("address value 1 == $input");
      // debugPrint("address value 2 == $location");
      if (response.isOkay) {
        predictions.value = response.predictions;
        debugPrint("address value 11 == ${response.predictions}");
      } else {
        debugPrint(response.errorMessage);
      }
      PlacesAutocompleteResponse postalCodeResponse =
          await _places.autocomplete(
        input,
        types: ['postal_code'],
        components: [Component(Component.country, "us")],
        region: "us",
      );
      if (postalCodeResponse.isOkay) {
        predictions.value = postalCodeResponse.predictions;
        debugPrint(
            "postal code predictions == ${postalCodeResponse.predictions}");
      } else {
        debugPrint(postalCodeResponse.errorMessage);
      }
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
