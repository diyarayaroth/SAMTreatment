import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/Services/Shared_pref.dart';
import 'package:health_care/screens/Home/view/home.dart';
import 'package:health_care/screens/splash/view/onboarding_screen1.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final RxBool user = false.obs;
  getUser() async {
    user.value = (await Preferances.prefGetBool("isUser", false))!;
  }

  @override
  void initState() {
    getUser();
    super.initState();
    getStarted();
  }

  getStarted() {
    Future.delayed(const Duration(seconds: 3), () {
      // if (user.value == true) {
      //   Get.to(const InsuranceScreen());
      // } else {
      //   Get.to(OnboardingScreen());
      // }
      // Get.to(OnboardingScreen());
      Get.offAll(OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAsset.splash), fit: BoxFit.cover)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAsset.splashLogo,
                  height: 200,
                  width: 200,
                ),
                verticalSpacing(30),
                const Text(
                  AppStrings.findTreatment,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(72, 130, 9, 1)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
