import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/app_text.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/widgets/custom/custom_book_container.dart';

import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:health_care/widgets/custom/custom_sizebox.dart';
import 'package:health_care/widgets/primary/primary_padding.dart';
import 'package:health_care/widgets/primary/primary_scrollview.dart';
import 'package:health_care/widgets/primary/primary_textfield.dart';

class HomeListScreen extends StatelessWidget {
  const HomeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PrimaryPadding(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: Sizes.s50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButton(
                    icon: Icons.menu,
                    borderRadius: 15,
                    height: Sizes.s48.h,
                    width: Sizes.s48.w,
                    onTap: () {},
                    text: '',
                  ),
                  SizedBox(
                    height: Sizes.s48.h,
                    width: Sizes.s243.w,
                    child: PrimaryTextField(
                      color: AppColor.searchbarColor.withOpacity(0.10),
                      hintText: AppStrings.zipCodeOrCity,
                      prefix: const Icon(
                        Icons.search,
                        color: AppColor.blackColor,
                      ),
                      contentPadding: EdgeInsets.only(left: Sizes.s10.w),
                    ),
                  ),
                  CustomButton(
                    text: "Map",
                    borderRadius: 15,
                    height: Sizes.s48.h,
                    width: Sizes.s48.w,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBoxH20(),
            appText(
              "Results for 395006,10 Doctors",
              style: AppTextStyle.regulerS14Black,
            ),
            // SizedBoxH20(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 100,
                padding: EdgeInsets.symmetric(vertical: Sizes.s10.h),
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CustomBookContainer(
                        doctorName: 'dr. pediatrician',
                        specialist: 'Denstist',
                        experience: '7 Years experience',
                        time: '10:00AM Tomorrow',
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
            // SizedBoxH20(),
          ],
        ),
      ),
    );
  }
}
