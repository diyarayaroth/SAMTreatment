import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/splash/Controller/onboarding_controller.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:health_care/widgets/primary/primary_padding.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final OnboardingController controller = Get.put(OnboardingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: Sizes.s20.w,
                ),
                child: Image.asset(
                  AppAsset.on1,
                  fit: BoxFit.fill,
                  height: Get.height * 0.50,
                  width: Get.width,
                ),
              ),
              verticalSpacing(103),
              const PrimaryPadding(
                child: Column(
                  children: [
                    Text(AppStrings.searchForTreatment,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.blackColor,
                        )),
                    Text(
                      AppStrings.ontext,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColor.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacing(30),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: CustomButton(
              txtColor: AppColor.whiteColor,
              bgColor: AppColor.primaryColor,
              text: AppStrings.getStarted,
              borderRadius: 10,
              height: Sizes.s50.h,
              width: Sizes.s330.w,
              onTap: controller.onGetStarted,
            ),
          ),

          // Obx(
          //   () => GestureDetector(
          //     onTap: controller.onGetSkip,
          //     child: Text(
          //       controller.currentPage.value == controller.pages.length - 3
          //           ? AppStrings.skip
          //           : AppStrings.previous,
          //       style: const TextStyle(color: AppColor.greyColor, fontSize: 14),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 15),
        ]),
      ),
    );
  }
}
