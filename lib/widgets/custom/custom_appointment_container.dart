import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:health_care/widgets/custom/custom_sizebox.dart';

import '../../utils/app_text.dart';

class CustomAppiontmentContainer extends StatelessWidget {
  final String? doctorName;
  final String? specialist;
  final String? status;
  final String? date;
  final String? time;
  final VoidCallback? oncanclled;
  final VoidCallback? onRescheduled;

  const CustomAppiontmentContainer(
      {super.key,
      this.doctorName,
      this.status,
      this.date,
      this.time,
      this.specialist,
      this.oncanclled,
      this.onRescheduled});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: Get.height * 0.25,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(15),
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
                        doctorName ?? "",
                        style: AppTextStyle.heading18Black,
                      ),
                      appText(
                        specialist ?? "",
                        style: AppTextStyle.heading14Black700,
                      ),
                      appText(
                        status ?? "",
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
                            date ?? "",
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
                            time ?? "",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    text: "Cancel",
                    txtColor: AppColor.blackColor,
                    bgColor: AppColor.whiteColor,
                    borderColor: AppColor.blackColor,
                    borderRadius: 5,
                    height: Sizes.s34.h,
                    width: Sizes.s150.w,
                    onTap: () {},
                  ),
                  CustomButton(
                    text: "Reschedule",
                    borderRadius: 5,
                    height: Sizes.s34.h,
                    width: Sizes.s150.w,
                    onTap: () {},
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
