// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Home/controller/insurance_controller.dart';
import 'package:health_care/screens/Home/view/home.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/function.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/widgets/custom/custom_button.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  RxString isSelected = "FT".obs;
  final insuranceController = Get.put(InsuranceController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.whiteColor,
          title: const Text('Filter Screen'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
                decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 0.1,
                  offset: const Offset(0, 0.3),
                ),
              ],
              border: const Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            )),
          )),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: <Widget>[
                Container(
                  width: 140, // Fixed width for the sidebar
                  color: AppColor.colorF1F1F1,
                  child: Obx(
                    () => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          title: Text('Facility Types',
                              style: isSelected.value == "FT"
                                  ? AppTextStyle.appBarTextTitle.copyWith(
                                      fontSize: 18, fontWeight: FontWeight.w900)
                                  : AppTextStyle.greySubTitle
                                      .copyWith(color: AppColor.greyColor)),
                          tileColor: isSelected.value == "FT"
                              ? Colors.black
                              : AppColor.lightGrey,
                          onTap: () {
                            _tabController.animateTo(0);
                            isSelected.value = "FT";
                          },
                        ),
                        ListTile(
                          title: Text('Poppular Filter',
                              style: isSelected.value == "PF"
                                  ? AppTextStyle.appBarTextTitle.copyWith(
                                      fontSize: 18, fontWeight: FontWeight.w900)
                                  : AppTextStyle.greySubTitle
                                      .copyWith(color: AppColor.greyColor)),
                          tileColor: isSelected.value == "PF"
                              ? Colors.black
                              : AppColor.lightGrey,
                          onTap: () {
                            _tabController.animateTo(1);
                            isSelected.value = "PF";
                          },
                        ),
                        ListTile(
                          title: Text('Payment/Insurance/Funding Accepted',
                              style: isSelected.value == "PI"
                                  ? AppTextStyle.appBarTextTitle.copyWith(
                                      fontSize: 18, fontWeight: FontWeight.w900)
                                  : AppTextStyle.greySubTitle
                                      .copyWith(color: AppColor.greyColor)),
                          tileColor: isSelected.value == "PI"
                              ? Colors.black
                              : AppColor.lightGrey,
                          onTap: () {
                            _tabController.animateTo(2);
                            isSelected.value = "PI";
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children: <Widget>[
                      FacilityTab(
                        status: true,
                      ),
                      PopularFilterTab(
                        status: true,
                      ),
                      PaymentTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: CustomButton(
                    txtColor: AppColor.blackColor,
                    bgColor: AppColor.whiteColor,
                    text: "Clear Filter",
                    borderRadius: 0,
                    height: Sizes.s50.h,
                    onTap: () {
                      for (var element in insuranceController.filterChipList) {
                        element.isChecked.value = false;
                      }

                      insuranceController.filterChipList[0].isChecked.value =
                          true;
                      insuranceController.aPIcall();
                      Get.off(() => const InsuranceScreen());
                    }),
              ),
              Expanded(
                child: CustomButton(
                    txtColor: AppColor.whiteColor,
                    bgColor: AppColor.primaryColor,
                    text: "Apply Filter",
                    borderRadius: 0,
                    height: Sizes.s50.h,
                    width: Sizes.s330.w,
                    onTap: () async {
                      bool isAnyFilterChecked = insuranceController
                          .filterChipList
                          .any((element) => element.isChecked.value == true);
                      if (isAnyFilterChecked) {
                        insuranceController.onSearchFilter(false);
                        Get.off(() => const InsuranceScreen());
                      } else {
                        CommonFunctions.toast("Select at least one filter");
                      }
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class FacilityTab extends StatelessWidget {
  final bool status;

  FacilityTab({super.key, required this.status});
  final insuranceController = Get.put(InsuranceController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: status == true
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // status == true
          //     ? SizedBox.shrink()
          //     : Divider(
          //         color: Colors.grey,
          //         thickness: 1,
          //       ),
          Padding(
            padding: status == true
                ? const EdgeInsets.only(left: 10, bottom: 8)
                : const EdgeInsets.only(left: 10),
            child: const Text(
              'Facility Types',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Obx(
            () => Column(
              children: insuranceController.facilities.map((facility) {
                return SizedBox(
                  height:
                      status == true ? Get.height * 0.06 : Get.height * 0.035,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.black,
                        value: facility.isChecked.value,
                        onChanged: (value) {
                          if (value == true) {
                            facility.isChecked.value = value!;
                          } else {
                            int selectedCount = insuranceController.facilities
                                .where((f) => f.isChecked.value == true)
                                .length;
                            if (selectedCount > 1) {
                              facility.isChecked.value = value!;
                            }
                          }
                        },
                      ),
                      status == true
                          ? SizedBox(width: 150, child: Text(facility.name))
                          : Text(facility.name),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class PopularFilterTab extends StatelessWidget {
  final bool status;

  PopularFilterTab({super.key, required this.status});
  final insuranceController = Get.put(InsuranceController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: status == true
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: status == true
                ? const EdgeInsets.only(left: 10, bottom: 8)
                : const EdgeInsets.only(left: 10),
            child: const Text(
              'Popular Filter',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Obx(
            () => Column(
              children: insuranceController.populerFilter.map((facility) {
                return SizedBox(
                  height:
                      status == true ? Get.height * 0.06 : Get.height * 0.035,
                  child: Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.black,
                        value: facility.isChecked.value,
                        onChanged: (value) {
                          facility.isChecked.value = value!;

                          log("value: $value , ${facility.name}");
                        },
                      ),
                      status == true
                          ? SizedBox(width: 150, child: Text(facility.name))
                          : Text(facility.name),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentTab extends StatelessWidget {
  final insuranceController = Get.put(InsuranceController());

  PaymentTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          const Text(
            'Payment/insurance/funding Accepted',
            style: TextStyle(fontSize: 20),
          ),
          verticalSpacing(10),
          Obx(
            () => Column(
              children:
                  insuranceController.paymentAcceptedCheckList.map((facility) {
                return Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.black,
                      value: facility.isChecked.value,
                      onChanged: (value) {
                        facility.isChecked.value = value!;

                        log("value: $value , ${facility.name}");
                      },
                    ),
                    SizedBox(width: 150, child: Text(facility.name)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
