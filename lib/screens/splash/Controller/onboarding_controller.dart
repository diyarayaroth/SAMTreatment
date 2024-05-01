import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Home/View/home_List_screen.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:health_care/widgets/custom/custom_dailog.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  TextEditingController zipCodeController = TextEditingController();
  RxInt currentPage = 0.obs;
  final List<PageData> pages = [
    PageData(
        onImage: AppAsset.on1,
        title: AppStrings.findDoctorOn1,
        subtitle: AppStrings.ontext,
        padding: EdgeInsets.only(
          right: Sizes.s20.w,
        )),
    PageData(
        onImage: AppAsset.on2,
        title: AppStrings.chooseDoctorOn2,
        subtitle: AppStrings.ontext,
        padding: EdgeInsets.only(
          left: Sizes.s20.w,
        )),
    PageData(
        onImage: AppAsset.on3,
        title: AppStrings.easyAppointmentOn3,
        subtitle: AppStrings.ontext,
        padding: EdgeInsets.only(
          right: Sizes.s20.w,
        )),
  ].obs;
  void onGetStarted() {
    if (currentPage.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      Get.dialog(CustomDailog(
        title: 'Add Zipcode',
        controller: zipCodeController,
      ));
    }
  }

  void onGetSkip() {
    if (currentPage.value == pages.length - 3) {
      pageController.jumpToPage(pages.length - 1);
    } else {
      pageController.previousPage(
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }
}

class PageData {
  final padding;
  final String title;
  final String subtitle;
  final String onImage;
  PageData({
    required this.padding,
    required this.title,
    required this.subtitle,
    required this.onImage,
  });
}
