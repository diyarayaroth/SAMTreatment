import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/helper.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerEffect(int itemCount) {
  return ListView.builder(
    shrinkWrap: true,
    itemCount: itemCount,
    padding: EdgeInsets.symmetric(vertical: Sizes.s10.h),
    itemBuilder: (context, index) {
      return Column(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColor.whiteColor,
              ),
              child: Column(children: [
                Shimmer.fromColors(
                  baseColor: AppColor.lightGrey,
                  highlightColor: AppColor.whiteColor,
                  child: Container(
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColor.lightGrey,
                    ),
                  ),
                ),
                verticalSpacing(10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppColor.lightGrey,
                            highlightColor: AppColor.whiteColor,
                            child: Container(
                              width: Get.width.h * 0.6,
                              height: Get.height * 0.025,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.lightGrey,
                              ),
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: AppColor.lightGrey,
                            highlightColor: AppColor.whiteColor,
                            child: Container(
                              width: Get.width.h * 0.2,
                              height: Get.height * 0.025,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.lightGrey,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpacing(10),
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppColor.lightGrey,
                            highlightColor: AppColor.whiteColor,
                            child: Container(
                              width: Get.width * 0.05,
                              height: Get.height * 0.025,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.lightGrey,
                              ),
                            ),
                          ),
                          horizontalSpacing(5),
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: AppColor.lightGrey,
                              highlightColor: AppColor.whiteColor,
                              child: Container(
                                height: Get.height * 0.025,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.lightGrey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpacing(10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppColor.lightGrey,
                            highlightColor: AppColor.whiteColor,
                            child: Container(
                              width: Get.width * 0.05,
                              height: Get.height * 0.025,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.lightGrey,
                              ),
                            ),
                          ),
                          horizontalSpacing(5),
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: AppColor.lightGrey,
                              highlightColor: AppColor.whiteColor,
                              child: Container(
                                height: Get.height * 0.05,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.lightGrey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpacing(10),
                      Shimmer.fromColors(
                        baseColor: AppColor.lightGrey,
                        highlightColor: AppColor.whiteColor,
                        child: Container(
                          width: Get.width * 0.5,
                          height: Get.height * 0.03,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppColor.lightGrey,
                          ),
                        ),
                      ),
                      verticalSpacing(10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppColor.lightGrey,
                            highlightColor: AppColor.whiteColor,
                            child: Container(
                              width: Get.width * 0.05,
                              height: Get.height * 0.025,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.lightGrey,
                              ),
                            ),
                          ),
                          horizontalSpacing(5),
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: AppColor.lightGrey,
                              highlightColor: AppColor.whiteColor,
                              child: Container(
                                height: Get.height * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.lightGrey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpacing(10),
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: AppColor.lightGrey,
                            highlightColor: AppColor.whiteColor,
                            child: Container(
                              width: Get.width * 0.2,
                              height: Get.height * 0.03,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColor.lightGrey,
                              ),
                            ),
                          ),
                          horizontalSpacing(5),
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: AppColor.lightGrey,
                              highlightColor: AppColor.whiteColor,
                              child: Container(
                                height: Get.height * 0.03,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.lightGrey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
