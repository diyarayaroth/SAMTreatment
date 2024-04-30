import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:health_care/screens/splash/view/onboarding_screen1.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

getStarted() {
  Future.delayed(const Duration(seconds: 5), () {
    Get.to(OnboardingScreen());
  });
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getStarted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAsset.splash), fit: BoxFit.cover)),
          child: Center(
              child: Image.asset(
            AppAsset.splashLogo,
            height: 200,
            width: 200,
          )),
        ),
      ),
    );
  }
}
