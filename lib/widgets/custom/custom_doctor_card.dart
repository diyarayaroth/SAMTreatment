import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Home/Model/doctor_list_model.dart';
import 'package:health_care/screens/Home/View/about_doctor_screen.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/app_text.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorComponent extends StatelessWidget {
  final ProviderElement providerElement;
  const DoctorComponent({
    super.key,
    required this.providerElement,
  });
  String getImage(String gender) {
    switch (gender) {
      case AppStrings.male:
        return AppAsset.doctorMale;
      case AppStrings.female:
        return AppAsset.doctorFemale;
      case AppStrings.Other:
        return AppAsset.doctor1;
      case AppStrings.unknown:
        return AppAsset.doctor1;
      default:
    }
    return '';
  }

  String get fullAddress {
    return "${providerElement.address.street1}, ${providerElement.address.street2},${providerElement.address.city}, ${providerElement.address.state}, ${providerElement.address.zipcode}";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          Get.to(
            () => AboutDoctorScreen(
              providerElement: providerElement,
              address: fullAddress,
            ),
          );
        },
        child: Container(
          // height: Get.height * 0.198,
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
                        child: Image.asset(
                            getImage(providerElement.provider.gender),
                            fit: BoxFit.cover,
                            height: Sizes.s100.h,
                            width: Sizes.s100.w)),
                    horizontalSpacing(10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        providerElement.provider.name.isNotEmpty
                            ? SizedBox(
                                width: Sizes.s200.w,
                                child: appText(providerElement.provider.name,
                                    style: AppTextStyle.heading18Black
                                        .copyWith(fontSize: Sizes.s14),
                                    maxLines: 2,
                                    softWrap: true,
                                    isTextOverflow: false),
                              )
                            : SizedBox.shrink(),
                        verticalSpacing(2),
                        providerElement.provider.specialties.isNotEmpty
                            ? SizedBox(
                                width: Sizes.s200.w,
                                child: appText(
                                    providerElement.provider.specialties
                                        .toString(),
                                    style: AppTextStyle.heading14Black700
                                        .copyWith(fontSize: Sizes.s12),
                                    maxLines: 2,
                                    softWrap: true,
                                    isTextOverflow: false),
                              )
                            : SizedBox.shrink(),
                        verticalSpacing(2),
                        providerElement.provider.languages.isNotEmpty
                            ? appText(
                                providerElement.provider.languages.toString(),
                                style: AppTextStyle.regulerS14Black.copyWith(
                                  color: AppColor.searchTextColor,
                                ),
                              )
                            : SizedBox.shrink(),
                        // appText(
                        //   gender.toString(),
                        //   style: AppTextStyle.regulerS14Black.copyWith(
                        //     color: AppColor.searchTextColor,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
                verticalSpacing(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appText(
                          "Distance",
                          style: AppTextStyle.heading14Black700,
                        ),
                        appText(
                          "(${providerElement.distance.toStringAsFixed(2)}) ",
                          style: AppTextStyle.reguler12grey,
                        ),
                      ],
                    ),
                    CustomButton(
                      text: "Call",
                      borderRadius: 5,
                      height: Sizes.s34.h,
                      width: Sizes.s90.w,
                      onTap: () {
                        launch("tel:${providerElement.address.phone} ");
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
