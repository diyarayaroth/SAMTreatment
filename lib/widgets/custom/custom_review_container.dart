import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_text.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:health_care/widgets/custom/custom_sizebox.dart';

class CustomReviewContainer extends StatelessWidget {
  final String doctorName;
  final String specialist;
  final String status;
  final String date;
  final String time;
  final VoidCallback onPressed;

  const CustomReviewContainer(
      {super.key,
      required this.doctorName,
      required this.specialist,
      required this.status,
      required this.date,
      required this.time,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.25,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(AppAsset.doctor1,
                      fit: BoxFit.cover,
                      height: Sizes.s100.h,
                      width: Sizes.s100.w),
                ),
                horizontalSpacing(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appText(
                      "Dr. $doctorName",
                      style: AppTextStyle.heading18Black,
                    ),
                    appText(
                      specialist,
                      style: AppTextStyle.heading14Black700,
                    ),
                    appText(
                      status,
                      style: AppTextStyle.regulerS14Black.copyWith(
                        color: AppColor.pendingColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBoxH5(),
            Container(
              height: Sizes.s32.h,
              width: Get.width,
              decoration: BoxDecoration(
                color: AppColor.lightGrey.withOpacity(0.29),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: AppColor.blackColor,
                          size: Sizes.s18.h,
                        ),
                        horizontalSpacing(5),
                        appText(
                          date,
                          style: AppTextStyle.reguler12grey.copyWith(
                            color: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_filled,
                          color: AppColor.blackColor,
                          size: Sizes.s18.h,
                        ),
                        horizontalSpacing(5),
                        appText(
                          time,
                          style: AppTextStyle.reguler12grey.copyWith(
                            color: AppColor.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBoxH5(),
            SizedBoxH5(),
            CustomButton(
              text: "Add Review",
              borderRadius: 5,
              height: Sizes.s34.h,
              width: Get.width,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
