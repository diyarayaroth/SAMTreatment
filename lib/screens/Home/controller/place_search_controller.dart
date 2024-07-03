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
    } else {
      debugPrint(response.errorMessage);
    }
  }

  // getPlaceDetails function use for get place details
  Future<PlacesDetailsResponse> getPlaceDetails(String placeId) async {
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);
    if (detail.isOkay) {
      address.value = detail.result.formattedAddress ?? "";

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
