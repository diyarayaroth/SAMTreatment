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
  var dropdownValue = ''.obs;
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
  RxBool isOpen = false.obs;
  RxBool isFilterSelected = true.obs;

  var dropdownValue1 = [].obs;
  var dropdownValue2 = [].obs;

  RxDouble distanceInMeters = 0.0.obs;

  RxString includeBupren = "0".obs;
  RxString includeHRSA = ''.obs;
  RxString includeOTP = ''.obs;
  RxString sType = ''.obs;
  var pageNumber = 1.obs;
  var sCodeList = [].obs;

  @override
  void onInit() {
    dropdownValue = distanceList[4].obs;
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
        ? onSearchFilter(false)
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

  onSearchFilter(
    bool isLoadMore,
  ) {
    pageNumber.value = isLoadMore == true ? pageNumber.value : 1;
    isLoadMore == false ? getInsListRes.clear() : null;
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
      page: isLoadMore == true ? pageNumber.toString() : "1",
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
      "limitType": bodyValue.limitType,
      "limitValue": bodyValue.limitValue,
      "pageSize": bodyValue.pageSize,
      "page": bodyValue.page,
      "sort": bodyValue.sort,
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
        if (pageNumber.value == 1) {
          getInsListRes = insList.rows ?? [];
          isLoading.value = false;
        } else {
          getInsListRes.addAll(insList.rows ?? []);
          isLoading.value = false;
        }
        debugPrint("Check my ins list 21 ${jsonEncode(getInsListRes)}");
      } else {
        isLoading.value = false;
        throw Exception(result.data);
      }
      return getInsListRes;
    } catch (e) {
      isLoading.value = false;
      isSearching.value = false;
      CommonFunctions.toast("Please Select Correct Location");
      debugPrint("Check my error $e");
    }
  }

  loadMore() async {
    debugPrint("Check my page number before ${pageNumber.value}");
    if (!isLoading.value) {
      pageNumber.value++;
      isLoading.value = true;
      debugPrint("Check my page number after ${pageNumber.value}");
      await onSearchFilter(true);
    }
  }
}
