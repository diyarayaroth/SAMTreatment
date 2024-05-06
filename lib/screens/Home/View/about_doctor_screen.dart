import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Home/Model/doctor_list_model.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/widgets/custom/custom_sizebox.dart';
import 'package:health_care/widgets/primary/primary_appbar.dart';

class AboutDoctorScreen extends StatelessWidget {
  final Key? key;
  final ProviderElement providerElement;
  final String address;

  const AboutDoctorScreen({
    this.key,
    required this.providerElement,
    required this.address,
  });
  String getImage(String gender) {
    switch (gender) {
      case 'Male':
        return AppAsset.doctorMale;
      case 'Female':
        return AppAsset.doctorFemale;
      case 'Other':
        return AppAsset.doctor1;
      case 'unknown':
        return AppAsset.doctor1;
      default:
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.95),
              image: const DecorationImage(
                  image: AssetImage(AppAsset.drawerImg), fit: BoxFit.cover)),
          child: Column(
            children: [
              verticalSpacing(10),
              // "About Doctor"
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    AppStrings.aboutDoctor,
                    style: AppTextStyle.appBarTextTitle.copyWith(
                      color: Colors.white,
                      fontSize: Sizes.s20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 150,
              ),
              Expanded(
                child: Container(
                  height: Get.height * 0.3,
                  width: Get.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment(-0.7, -1.45),
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(
                            Radius.circular(100),
                          ),
                        ),
                        child: Image.asset(
                          getImage(providerElement.provider.gender),
                          fit: BoxFit.cover,
                          height: Sizes.s140.h,
                          width: Sizes.s140.h,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Sizes.s80, horizontal: Sizes.s26),
                        child: Container(
                          // decoration: BoxDecoration(
                          //   color: Colors.red,
                          // ),
                          height: Get.height,
                          width: Get.width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  providerElement.provider.name ?? " ",
                                  style: AppTextStyle.title,
                                ),
                                SizedBoxH5(),
                                Text('Specialist Cardiologist',
                                    style: AppTextStyle.heading14Black700
                                        .copyWith(
                                            fontSize: Sizes.s16,
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w500)),
                                SizedBoxH5(),
                                Text(
                                  providerElement.provider.languages
                                          .toString() ??
                                      " ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBoxH20(),
                                //+8801800000000
                                Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: AppColor.blackColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      providerElement.address.phone ?? " ",
                                      style: AppTextStyle.heading14Black700
                                          .copyWith(
                                              fontSize: Sizes.s16,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBoxH20(),
                                //A-5 Avalon Complex, Bandra Mumbai
                                Row(
                                  children: [
                                    Icon(
                                      Icons.home,
                                      color: AppColor.blackColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 270,
                                      child: Text(
                                        address ?? " ",
                                        style: AppTextStyle.heading14Black700
                                            .copyWith(
                                                fontSize: Sizes.s16,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
