import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:health_care/screens/Insurance/view/eocoding_service.dart';
import 'dart:convert';
import 'package:health_care/Api/network.dart';
import 'package:health_care/screens/Insurance/model/insurance_model.dart';

class InsuranceController extends GetxController {
  List<Rows> getInsListRes = <Rows>[].obs;
  List<Location> locations = <Location>[].obs;
  var distanceController = [].obs;
  var distanceList = <String>[
    '5 miles',
    '10 miles',
    '15 miles',
    '20 miles',
    '25 miles',
    '50 miles',
    '100 miles',
  ];
  RxString dropdownValue = ''.obs;
  RxString zipCode = ''.obs;
  RxString latlong = ''.obs;
  RxString miles = ''.obs;

  TextEditingController zipCodeController = TextEditingController();
  // create filterChipList for filter chip
  var filterChipList = <Facility>[].obs;

  var facilities = [
    Facility(name: 'Substance Use', isChecked: false.obs),
    Facility(name: 'Mental Health', isChecked: false.obs),
    Facility(name: 'Health Care Center', isChecked: false.obs),
    Facility(name: 'Buprenorphine Practitioners', isChecked: false.obs),
    Facility(name: 'Opioid Treatment Programs', isChecked: false.obs),
  ];

  var populerFilter = [
    Facility(name: 'Veterans Affairs', isChecked: false.obs),
    Facility(name: 'Medicaid', isChecked: false.obs),
    Facility(name: 'Adults', isChecked: false.obs),
    Facility(name: 'Outpatient', isChecked: false.obs),
    Facility(name: 'Residential/24-hour residential', isChecked: false.obs),
    Facility(name: 'Telemedicine/telehealth therapy', isChecked: false.obs),
  ];

  var paymentAcceptedCheckList = [
    Facility(name: 'IHS/Tribal/Urban (ITU) funds', isChecked: false.obs),
    Facility(name: 'Medicare', isChecked: false.obs),
    Facility(name: 'Medicaid', isChecked: false.obs),
    Facility(
        name: 'Federal military insurance (e.g., TRICARE)',
        isChecked: false.obs),
    Facility(name: 'Private health insurance', isChecked: false.obs),
    Facility(name: 'Cash or self-payment', isChecked: false.obs),
    Facility(
        name: 'State-financed health insurance plan other than Medicaid',
        isChecked: false.obs),
  ];

  RxBool isSearching = false.obs;

  RxBool isLoading = false.obs;
  RxBool isMentalHealth = false.obs;
  RxBool isSubstanceUse = false.obs;
  // RxBool isHRSA = false.obs;
  // RxBool isOTP = false.obs;
  // RxBool isBupren = false.obs;
  RxString _latitude = ''.obs;
  RxString _longitude = ''.obs;

  var dropdownValue1 = [].obs;
  var dropdownValue2 = [].obs;

  // RxBool isSearching = false.obs;

  final _geocodingService = GeocodingService();

  @override
  void onInit() {
    dropdownValue = distanceList.first.obs;
    filterChipList
        .addAll([...facilities, ...populerFilter, ...paymentAcceptedCheckList]);
    // getInsuranceList();

    super.onInit();
  }

  // _showDialog() async {
  //   await Future.delayed(Duration(milliseconds: 1));
  //   Get.dialog(CustomDailog(
  //     isBack: false,
  //     title: 'Add Zipcode',
  //     controller: zipCodeController,
  //   ));
  // }

  getInsuranceList() async {
    isLoading.value = true;
    String? distance = dropdownValue.value.replaceAll(' miles', '');
    double distanceInMeters = double.parse(distance) * 1609.34;
    String? apiUrl =

        //"https://marketplace.api.healthcare.gov/api/v1/providers/search?apikey=i5809cXUIhvlCabIGOOyWD42c4MW1Wyv&year=2024&q=doctor&zipcode=$zip&type=Individual";
        "https://findtreatment.gov/locator/listing";
    debugPrint("Check my api url $apiUrl}");
    var body = {
      "sType": "BOTH",
      //"sAddr": "37.5042267,-121.9643745",
      "sAddr": latlong.value,
      "limitType": "2",
      "limitValue": distanceInMeters.toString(),
      "pageSize": "10",
      "page": "1",
      "sort": "0",
    };
    debugPrint("Check my body $body");
    var headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    try {
      var result = await NetworkAPICall().post(
        apiUrl,
        body,
        headers: headers,
      );
      if (result != null) {
        InsuranceListModel insList = InsuranceListModel.fromJson(result);
        getInsListRes = insList.rows ?? [];
        debugPrint("Check my ins list 21 ${jsonEncode(getInsListRes)}");
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception(result.data);
      }
      return getInsListRes;
    } catch (e) {
      debugPrint("Check my error $e");
    }
  }
}

class Facility {
  final String name;
  final RxBool isChecked;

  Facility({required this.name, required this.isChecked});
}
