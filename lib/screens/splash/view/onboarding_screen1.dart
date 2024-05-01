import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/splash/Controller/onboarding_controller.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:health_care/widgets/custom/custom_sizebox.dart';
import 'package:health_care/widgets/primary/primary_padding.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final OnboardingController controller = Get.put(OnboardingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: Get.height * 0.80,
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.pages.length,
                    onPageChanged: controller.onPageChanged,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: controller.pages[index].padding,
                            child: Image.asset(
                              controller.pages[index].onImage,
                              fit: BoxFit.fill,
                              height: Get.height * 0.50,
                              width: Get.width,
                            ),
                          ),
                          SizedBoxH103(),
                          PrimaryPadding(
                            child: Column(
                              children: [
                                Text(controller.pages[index].title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.blackColor,
                                    )),
                                Text(
                                  controller.pages[index].subtitle,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColor.greyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            Obx(
              () => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: CustomButton(
                  txtColor: AppColor.whiteColor,
                  bgColor: AppColor.primaryColor,
                  text: controller.currentPage.value ==
                          controller.pages.length - 1
                      ? AppStrings.getStart
                      : AppStrings.next,
                  borderRadius: 10,
                  height: Sizes.s50.h,
                  width: Sizes.s330.w,
                  onTap: controller.onGetStarted,
                ),
              ),
            ),
            Obx(
              () => GestureDetector(
                onTap: controller.onGetSkip,
                child: Text(
                  controller.currentPage.value == controller.pages.length - 3
                      ? AppStrings.skip
                      : AppStrings.previous,
                  style:
                      const TextStyle(color: AppColor.greyColor, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
