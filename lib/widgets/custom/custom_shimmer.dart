import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/widgets/custom/custom_sizebox.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerEffect() {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: 5,
    padding: EdgeInsets.symmetric(vertical: Sizes.s10.h),
    itemBuilder: (context, index) {
      return Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.whiteColor,
              ),
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: AppColor.lightGrey,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.lightGrey,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Shimmer.fromColors(
                          baseColor: AppColor.lightGrey,
                          highlightColor: AppColor.whiteColor,
                          child: Container(
                            width: Get.width.h * 0.5,
                            height: Get.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColor.lightGrey,
                            ),
                          ),
                        ),
                        SizedBoxH10(),
                        Shimmer.fromColors(
                          baseColor: AppColor.lightGrey,
                          highlightColor: AppColor.whiteColor,
                          child: Container(
                            width: Get.width.h * 0.5,
                            height: Get.height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColor.lightGrey,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBoxH10(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer.fromColors(
                      baseColor: AppColor.lightGrey,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        width: Get.width.h * 0.25,
                        height: Get.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.lightGrey,
                        ),
                      ),
                    ),
                    Shimmer.fromColors(
                      baseColor: AppColor.lightGrey,
                      highlightColor: AppColor.whiteColor,
                      child: Container(
                        width: Get.width.h * 0.2,
                        height: Get.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColor.lightGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
    },
  );
}
