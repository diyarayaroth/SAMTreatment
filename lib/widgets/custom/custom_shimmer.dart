import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/helper.dart';
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

//  Card(
//       elevation: 5,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: AppColor.blackColor,
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   SizedBox(
//                     width: context.width * 0.5,
//                     child: Text(
//                       "${providerElement.name1}",
//                       style: AppTextStyle.appBarTextTitle.copyWith(
//                         fontSize: 16,
//                         color: AppColor.whiteColor,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 2,
//                     ),
//                   ),
//                   Visibility(
//                     visible: providerElement.services?.isNotEmpty ?? false,
//                     child: CustomButton(
//                         bgColor: AppColor.whiteColor,
//                         borderRadius: 5,
//                         height: 30,
//                         width: 100,
//                         text: "More Services",
//                         txtColor: AppColor.blackColor,
//                         onTap: () {
//                           Get.to(() => InsuranceAboutScreen(
//                               providerElement: providerElement));
//                         }),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         const Icon(Icons.call, color: Colors.black, size: 16),
//                         horizontalSpacing(5),
//                         Text(" ${providerElement.phone}",
//                             style: AppTextStyle.regulerS14Black),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Image.asset(AppAsset.locationIcon,
//                             height: 15, width: 15),
//                         horizontalSpacing(5),
//                         Text("${providerElement.miles} Miles",
//                             style: AppTextStyle.regulerS14Black),
//                       ],
//                     ),
//                   ],
//                 ),
//                 verticalSpacing(10),
//                 Visibility(
//                   visible: providerElement.website?.isNotEmpty ?? false,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Icon(Icons.language, color: Colors.black, size: 16),
//                       horizontalSpacing(5),
//                       InkWell(
//                         onTap: () {
//                           // ignore: deprecated_member_use
//                           launch("${providerElement.website}");
//                         },
//                         child: SizedBox(
//                           width: context.width * 0.7,
//                           child: Text(
//                             " ${providerElement.website}",
//                             style: AppTextStyle.regulerS14Black.copyWith(
//                               color: Colors.blue,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 verticalSpacing(10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Icon(Icons.location_on,
//                             color: Colors.black, size: 16),
//                         horizontalSpacing(5),
//                         SizedBox(
//                           width: context.width * 0.7,
//                           child: Text(
//                             "${providerElement.street1}, ${providerElement.city}, ${providerElement.state}, ${providerElement.zip}",
//                             style: AppTextStyle.regulerS14Black,
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 verticalSpacing(10),
//                 Visibility(
//                   visible: providerElement.services?.isNotEmpty ?? false,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Services",
//                         style: AppTextStyle.appBarTextTitle.copyWith(
//                           fontSize: 16,
//                         ),
//                       ),
//                       verticalSpacing(10),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Image.asset(AppAsset.rightIcon,
//                               height: 15, width: 15),
//                           horizontalSpacing(5),
//                           SizedBox(
//                             width: context.width * 0.7,
//                             child: Text(
//                               "${providerElement.services?.first.f3}",
//                               style: AppTextStyle.regulerS14Black,
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 verticalSpacing(10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${AppStrings.source}: ",
//                       style: AppTextStyle.regulerS14Black.copyWith(
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(
//                         width: context.width * 0.6,
//                         child: facilityTypeData(facilityType)),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
  