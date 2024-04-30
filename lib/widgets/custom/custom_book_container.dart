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

class CustomBookContainer extends StatelessWidget {
  final String doctorName;
  final String specialist;
  final String experience;
  final String time;
  final VoidCallback onPressed;
  const CustomBookContainer(
      {super.key,
      required this.doctorName,
      required this.specialist,
      required this.experience,
      required this.time,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        height: Get.height * 0.198,
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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                        doctorName,
                        style: AppTextStyle.heading18Black,
                      ),
                      appText(
                        specialist,
                        style: AppTextStyle.heading14Black700,
                      ),
                      appText(
                        experience,
                        style: AppTextStyle.regulerS14Black.copyWith(
                          color: AppColor.searchTextColor,
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star,
                                      color: AppColor.starColor,
                                      size: 20,
                                    )),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBoxH2(),
              SizedBoxH2(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText(
                        "Next Available",
                        style: AppTextStyle.heading14Black700,
                      ),
                      appText(
                        time,
                        style: AppTextStyle.reguler12grey,
                      ),
                    ],
                  ),
                  CustomButton(
                    text: "Book Now",
                    borderRadius: 5,
                    height: Sizes.s34.h,
                    width: Sizes.s90.w,
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
