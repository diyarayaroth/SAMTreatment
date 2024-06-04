import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Home/Model/doctor_list_model.dart';
import 'package:health_care/screens/Insurance/model/insurance_model.dart';
import 'package:health_care/screens/Insurance/view/insurance_about_screen.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class InsuranceComponent extends StatelessWidget {
  final Rows providerElement;
  const InsuranceComponent({
    super.key,
    required this.providerElement,
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
                  CustomButton(
                      bgColor: AppColor.whiteColor,
                      borderRadius: 5,
                      height: 30,
                      width: 100,
                      text: "More Services",
                      txtColor: AppColor.blackColor,
                      onTap: () {
                        Get.to(() => InsuranceAboutScreen(
                            providerElement: providerElement));
                      })
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
                        Text(" ${providerElement.phone}",
                            style: AppTextStyle.regulerS14Black),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.language,
                            color: Colors.black, size: 16),
                        horizontalSpacing(5),
                        InkWell(
                          onTap: () {
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
                  ],
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
                            style: TextStyle(color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                verticalSpacing(10),
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
                    Image.asset(AppAsset.rightIcon, height: 15, width: 15),
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
                verticalSpacing(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Source: ",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      width: context.width * 0.6,
                      child: Text(
                        "National Substance Use and Mental Health Services Survey(N-SUMHSS)",
                        style: TextStyle(color: Colors.blue),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
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
