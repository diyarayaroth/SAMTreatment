import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'dart:convert';
import 'package:health_care/Api/network.dart';
import 'package:health_care/constants/baseurl.dart';
import 'package:health_care/screens/Home/model/insurance_model.dart';
import 'package:health_care/utils/constant.dart';
import 'package:health_care/utils/function.dart';

class InsuranceController extends GetxController {
  List<Rows> getInsListRes = <Rows>[].obs;
  List<Location> locations = <Location>[].obs;
  var distanceController = [].obs;
  RxString dropdownValue = ''.obs;
  RxString zipCode = ''.obs;
  RxString latlong = ''.obs;
  RxString miles = ''.obs;
  RxString address = ''.obs;

  TextEditingController zipCodeController = TextEditingController();
  var filterChipList = <Facility>[].obs;

  var facilities = [
    Facility(name: 'Substance Use', isChecked: true.obs),
    Facility(name: 'Mental Health', isChecked: true.obs),
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
  RxBool isFacilityTab = false.obs;
  RxBool isLoading = false.obs;
  RxBool isMentalHealth = false.obs;
  RxBool isSubstanceUse = false.obs;
  RxBool isFirst = true.obs;

  var dropdownValue1 = [].obs;
  var dropdownValue2 = [].obs;

  RxDouble distanceInMeters = 0.0.obs;

  RxString includeBupren = "0".obs;
  RxString includeHRSA = ''.obs;
  RxString includeOTP = ''.obs;
  RxString sType = ''.obs;
  var sCodeList = [].obs;

  @override
  void onInit() {
    dropdownValue = distanceList.first.obs;
    filterChipList
        .addAll([...facilities, ...populerFilter, ...paymentAcceptedCheckList]);
    super.onInit();
  }

  void facilityFilter() {
    bool isSubstanceUseSelected = false;
    bool isMentalHealthSelected = false;

    for (var facility in filterChipList) {
      if (facility.isChecked.value) {
        if (facility.name == 'Substance Use') {
          isSubstanceUseSelected = true;
        } else if (facility.name == 'Mental Health') {
          isMentalHealthSelected = true;
        }
      }
    }
    switch (isSubstanceUseSelected) {
      case true:
        switch (isMentalHealthSelected) {
          case true:
            sType.value = "BOTH";
            break;
          case false:
            sType.value = "SA";
            break;
        }
        break;
      case false:
        switch (isMentalHealthSelected) {
          case true:
            sType.value = "MH";
            break;
          case false:
            sType.value = "";
            break;
        }
        break;
    }

    includeBupren.value = filterChipList.any((facility) =>
            facility.name == 'Buprenorphine Practitioners' &&
            facility.isChecked.value)
        ? '1'
        : '0';
    includeHRSA.value = filterChipList.any((facility) =>
            facility.name == 'Health Care Center' && facility.isChecked.value)
        ? '1'
        : '0';
    includeOTP.value = filterChipList.any((facility) =>
            facility.name == 'Opioid Treatment Programs' &&
            facility.isChecked.value)
        ? '1'
        : '0';
  }

  aPIcall() {
    zipCodeController.text.isNotEmpty
        ? onSearchFilter()
        : CommonFunctions.toast("Please enter zip code");
  }

  void popularFilter() {
    sCodeList.clear();

    List<String> facilityNames = [
      'Veterans Affairs',
      'Medicaid',
      'Adults',
      'Outpatient',
      'Residential/24-hour residential',
      'Telemedicine/telehealth therapy',
      'IHS/Tribal/Urban (ITU) funds',
      'Medicare',
      'Federal military insurance (e.g., TRICARE)',
      'Private health insurance',
      'Cash or self-payment',
      'State-financed health insurance plan other than Medicaid',
    ];

    for (var facilityName in facilityNames) {
      if (filterChipList.any((facility) =>
          facility.name == facilityName && facility.isChecked.value)) {
        switch (facilityName) {
          case 'Veterans Affairs':
            if (!sCodeList.contains('VAMC')) {
              sCodeList.add('VAMC');
            }
            break;
          case 'Medicaid':
            if (!sCodeList.contains('MD')) {
              sCodeList.add('MD');
            }
            break;
          case 'Adults':
            if (!sCodeList.contains('ADLT')) {
              sCodeList.add('ADLT');
            }
            break;
          case 'Outpatient':
            if (!sCodeList.contains('OP')) {
              sCodeList.add('OP');
            }
            break;
          case 'Residential/24-hour residential':
            if (!sCodeList.contains('RES')) {
              sCodeList.add('RES');
            }
            break;
          case 'Telemedicine/telehealth therapy':
            if (!sCodeList.contains('TELE')) {
              sCodeList.add('TELE');
            }
            break;
          case 'IHS/Tribal/Urban (ITU) funds':
            if (!sCodeList.contains('ITU')) {
              sCodeList.add('ITU');
            }
            break;
          case 'Medicare':
            if (!sCodeList.contains('MC')) {
              sCodeList.add('MC');
            }
            break;
          case 'Federal military insurance (e.g., TRICARE)':
            if (!sCodeList.contains('MI')) {
              sCodeList.add('MI');
            }
            break;
          case 'Private health insurance':
            if (!sCodeList.contains('PI')) {
              sCodeList.add('PI');
            }
            break;
          case 'Cash or self-payment':
            if (!sCodeList.contains('SF')) {
              sCodeList.add('SF');
            }
            break;
          case 'State-financed health insurance plan other than Medicaid':
            if (!sCodeList.contains('SI')) {
              sCodeList.add('SI');
            }
            break;
        }
      }
    }
  }

  void onSearchFilter() {
    facilityFilter();
    popularFilter();
    String? distance = dropdownValue.value.replaceAll(' miles', '');
    distanceInMeters.value = double.parse(distance) * 1609.34;

    BodyModel bodyValue = BodyModel(
      sType: sType.value,
      sAddr: latlong.value,
      sCodes: sCodeList.isNotEmpty ? sCodeList.join(',') : "",
      includeBupren: includeBupren.value,
      includeHRSA: includeHRSA.value,
      includeOTP: includeOTP.value,
      limitType: "2",
      limitValue: distanceInMeters.value.toString(),
      pageSize: "10",
      page: "1",
      sort: "0",
    );

    getInsuranceList(bodyValue);
  }

  getInsuranceList(
    BodyModel bodyValue,
  ) async {
    isLoading.value = true;
    String? apiUrl = baseUrl;
    debugPrint("Check my api url $apiUrl}");
    var body = {
      "sType": bodyValue.sType,
      "sAddr": bodyValue.sAddr,
      "sCodes": bodyValue.sCodes,
      "includeBupren": bodyValue.includeBupren,
      "includeHRSA": bodyValue.includeHRSA,
      "includeOTP": bodyValue.includeOTP,
      "limitType": "2",
      "limitValue": bodyValue.limitValue,
      "pageSize": "1000",
      "page": "1",
      "sort": "0",
    };
    debugPrint("Check my body ${jsonEncode(body)}");
    var headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

    try {
      var result = await NetworkAPICall().post(
        apiUrl,
        body, // Rename the local variable 'body' to 'requestBody'
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
      CommonFunctions.toast("Something went wrong ${e} ");
      debugPrint("Check my error $e");
    }
  }
}
