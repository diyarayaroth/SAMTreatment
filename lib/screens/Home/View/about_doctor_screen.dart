import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/widgets/custom/custom_sizebox.dart';
import 'package:health_care/widgets/primary/primary_appbar.dart';

class AboutDoctorScreen extends StatelessWidget {
  const AboutDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: 'About Doctor',
        textColor: Colors.white,
        isLeading: true,
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.95),
        leadingIcon: Icons.arrow_back_ios_outlined,
        onBackPressed: () {
          Get.back();
        },
      ),
      // appBar: AppBar(
      //   title: Text(
      //     'About Doctor',
      //     style: AppTextStyle.appBarTextTitle.copyWith(
      //       color: Colors.white,
      //       fontSize: Sizes.s20,
      //       fontWeight: FontWeight.w500,
      //     ),
      //   ),
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //     onPressed: () {
      //       Get.back();
      //     },
      //   ),
      //   backgroundColor: Colors.black,
      // ),
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.95),
            image: DecorationImage(
                image: AssetImage(AppAsset.drawerImg), fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Expanded(
              child: Container(
                height: Get.height * 0.3,
                width: Get.width,
                decoration: BoxDecoration(
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
                        AppAsset.doctor1,
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
                                'Dr. Shruti Kedia',
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
                                'English',
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
                                    '+8801800000000',
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
                                      'A-5 Avalon Complex, Bandra Mumbai',
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
    );
  }
}
