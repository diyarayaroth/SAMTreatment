import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/Api/api_services.dart';
import 'package:health_care/Services/Shared_pref.dart';
import 'package:health_care/screens/Home/Model/doctor_list_model.dart';
import 'package:health_care/utils/loder.dart';

class HomeScreenController extends GetxController {
  Rx<DoctorListModel> doctorListResponse = DoctorListModel().obs;
  RxString zipCode = "".obs;

  @override
  void onInit() {
    getZipCode();

    super.onInit();
  }

  getZipCode() async {
    debugPrint("get Zip called");
    zipCode.value = await Preferances.getString("zipcode") ?? "";
    debugPrint("get Zip code===> ${zipCode.value}");
    getDoctorList(int.parse(
        "${zipCode.value.replaceAll('"', '').replaceAll('"', '').toString()}"));
  }

  getDoctorList(
    int? zip,
  ) async {
    String? apiUrl =
        "https://marketplace.api.healthcare.gov/api/v1/providers/search?apikey=i5809cXUIhvlCabIGOOyWD42c4MW1Wyv&year=2024&q=doctor&zipcode=$zip&type=Individual";
    debugPrint("Check my api url $apiUrl}");
    Loader.showLoader();

    return Api.getDoctorListApi(apiUrl).then((response) {
      debugPrint("Check count my loader : 1 $response");
      if (response != null) {
        debugPrint("Check my countloader 2");
        doctorListResponse.value = DoctorListModel.fromJson(response);

        debugPrint("Check doctorListResponse 27 ${doctorListResponse}");
        Loader.hideLoader();
      } else {
        debugPrint("Check my count loader 3");
        Loader.hideLoader();
        throw Exception(response.data);
      }
      // ignore: invalid_return_type_for_catch_error, avoid_print
    }).catchError((err) => print('error$err'));
  }
}
