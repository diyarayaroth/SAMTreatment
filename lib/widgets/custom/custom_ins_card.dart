import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Home/model/insurance_model.dart';
import 'package:health_care/screens/Home/view/about_screen.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class InsuranceComponent extends StatelessWidget {
  final Rows providerElement;
  final String facilityType;
  const InsuranceComponent({
    super.key,
    required this.providerElement,
    required this.facilityType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.blackColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.width * 0.5,
                    child: Text(
                      "${providerElement.name1}",
                      style: AppTextStyle.appBarTextTitle.copyWith(
                        fontSize: 16,
                        color: AppColor.whiteColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  Visibility(
                    visible: providerElement.services?.isNotEmpty ?? false,
                    child: CustomButton(
                        bgColor: AppColor.whiteColor,
                        borderRadius: 5,
                        height: 30,
                        width: 100,
                        text: "More Services",
                        txtColor: AppColor.blackColor,
                        onTap: () {
                          Get.to(() => InsuranceAboutScreen(
                              providerElement: providerElement));
                        }),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.call, color: Colors.black, size: 16),
                        horizontalSpacing(5),
                        InkWell(
                          onTap: () {
                            // ignore: deprecated_member_use
                            launch("tel:${providerElement.phone}");
                          },
                          child: Text(
                              " ${providerElement.phone?.substring(0, 12)}",
                              style: AppTextStyle.regulerS14Black),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset(AppAsset.locationIcon,
                            height: 15, width: 15),
                        horizontalSpacing(5),
                        Text("${providerElement.miles} Miles",
                            style: AppTextStyle.regulerS14Black),
                      ],
                    ),
                  ],
                ),
                verticalSpacing(10),
                Visibility(
                  visible: providerElement.website?.isNotEmpty ?? false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.language, color: Colors.black, size: 16),
                      horizontalSpacing(5),
                      InkWell(
                        onTap: () {
                          // ignore: deprecated_member_use
                          launch("${providerElement.website}");
                        },
                        child: SizedBox(
                          width: context.width * 0.7,
                          child: Text(
                            " ${providerElement.website}",
                            style: AppTextStyle.regulerS14Black.copyWith(
                              color: Colors.blue,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpacing(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.black, size: 16),
                        horizontalSpacing(5),
                        SizedBox(
                          width: context.width * 0.7,
                          child: Text(
                            "${providerElement.street1}, ${providerElement.city}, ${providerElement.state}, ${providerElement.zip}",
                            style: AppTextStyle.regulerS14Black,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpacing(10),
                Visibility(
                  visible: providerElement.services?.isNotEmpty ?? false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Services",
                        style: AppTextStyle.appBarTextTitle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      verticalSpacing(10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(AppAsset.rightIcon,
                              height: 15, width: 15),
                          horizontalSpacing(5),
                          SizedBox(
                            width: context.width * 0.7,
                            child: Text(
                              "${providerElement.services?.first.f3}",
                              style: AppTextStyle.regulerS14Black,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                verticalSpacing(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${AppStrings.source}: ",
                      style: AppTextStyle.regulerS14Black.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                        width: context.width * 0.6,
                        child: facilityTypeData(facilityType)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

facilityTypeData(String ft) {
  switch (ft) {
    case ("MH" || "SA"):
      return InkWell(
        onTap: () {
          // ignore: deprecated_member_use
          launch("https://info.nsumhss.samhsa.gov/");
        },
        child: Text(
          AppStrings.mhText,
          style: AppTextStyle.regulerS14Black.copyWith(
            color: Colors.blue,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      );
    case "HRSA":
      return InkWell(
        onTap: () {
          // ignore: deprecated_member_use
          launch("https://data.hrsa.gov/");
        },
        child: Text(
          AppStrings.hRSAText,
          style: AppTextStyle.regulerS14Black.copyWith(
            color: Colors.blue,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      );
    case ("BUPREN" || "OTP"):
      return InkWell(
        onTap: () {
          // ignore: deprecated_member_use
          launch("https://dpt2.samhsa.gov/treatment/directory.aspx");
        },
        child: Text(
          AppStrings.bUPRENText,
          style: AppTextStyle.regulerS14Black.copyWith(
            color: Colors.blue,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      );
    default:
      return null;
  }
}
