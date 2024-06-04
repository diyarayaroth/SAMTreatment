import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/Api/network.dart';
import 'package:health_care/Services/Shared_pref.dart';

import 'package:health_care/constants/baseurl.dart';
import 'package:health_care/screens/Home/Model/doctor_list_model.dart';
import 'package:health_care/utils/log_utils.dart';
import 'package:health_care/widgets/custom/custom_dailog.dart';

class HomeScreenController extends GetxController {
  TextEditingController searchController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  List<ProviderElement> getAllDoctorList = <ProviderElement>[].obs;
  List<ProviderElement> getDoctorListRes = <ProviderElement>[].obs;

  RxBool isLoading = false.obs;
  // RxBool isSearching = false.obs;
  List<ProviderElement> filteredTopics = <ProviderElement>[].obs;

  @override
  void onInit() {
    // _showDialog();
    filteredTopics.addAll(getAllDoctorList);
    debugPrint("Check my doctor list 21 ${filteredTopics.length}");

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

  void searchQuery(String value) {
    debugPrint('search Query Function called : $value');
    if (value.isNotEmpty) {
      List<ProviderElement> dummyListData = [];
      for (var map in getAllDoctorList) {
        if (map.provider.name.toLowerCase().contains(value.toLowerCase()) ||
            map.provider.specialties.any((specialty) =>
                specialty.toLowerCase().contains(value.toLowerCase()))) {
          dummyListData.addAll([map]);
        }
      }
      filteredTopics.clear();
      filteredTopics.addAll(dummyListData);
      return;
    } else {
      filteredTopics.clear();
      filteredTopics.addAll(getAllDoctorList);
    }
  }

  getDoctorList(int? zip) async {
    isLoading.value = true;
    String? apiUrl =

        //"https://marketplace.api.healthcare.gov/api/v1/providers/search?apikey=i5809cXUIhvlCabIGOOyWD42c4MW1Wyv&year=2024&q=doctor&zipcode=$zip&type=Individual";
        "${baseUrl}providers/search?apikey=$apiKey&year=2024&q=doctor&zipcode=$zip&type=Individual";
    debugPrint("Check my api url $apiUrl}");

    try {
      var result = await NetworkAPICall().get(apiUrl);
      if (result != null) {
        DoctorListModel doctorList = DoctorListModel.fromJson(result);
        getAllDoctorList = doctorList.providers;
        filteredTopics.addAll(getAllDoctorList);
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception(result.data);
      }
      return getAllDoctorList;
    } catch (e) {
      debugPrint("Check my error $e");
    }
  }
}
