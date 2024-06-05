// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Insurance/controller/insurance_controller.dart';
import 'package:health_care/screens/Insurance/view/insurance.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/widgets/custom/custom_button.dart';

class MyTabScreen extends StatefulWidget {
  const MyTabScreen({super.key});

  @override
  _MyTabScreenState createState() => _MyTabScreenState();
}

class _MyTabScreenState extends State<MyTabScreen>
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
            preferredSize: Size.fromHeight(0),
            child: Container(
                decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 0.1,
                  offset: Offset(0, 0.3),
                  // changes position of shadow
                  // changes position of shadow
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
                              style: TextStyle(
                                  color: isSelected.value == "FT"
                                      ? Colors.black
                                      : AppColor.darkGrey)),
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
                              style: TextStyle(
                                  color: isSelected.value == "PF"
                                      ? Colors.black
                                      : AppColor.darkGrey)),
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
                              style: TextStyle(
                                  color: isSelected.value == "PI"
                                      ? Colors.black
                                      : AppColor.darkGrey)),
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
                    text: "Cancel",
                    borderRadius: 0,
                    height: Sizes.s50.h,
                    onTap: () {}),
              ),
              Expanded(
                child: CustomButton(
                    txtColor: AppColor.whiteColor,
                    bgColor: AppColor.primaryColor,
                    text: "Apply Filter",
                    borderRadius: 0,
                    height: Sizes.s50.h,
                    width: Sizes.s330.w,
                    onTap: () {
                      Get.off(() => const InsuranceScreen());
                      insuranceController.onSearchFilter();
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 8),
            child: Text(
              'Facility Types',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Obx(
            () => Column(
              children: insuranceController.facilities.map((facility) {
                return SizedBox(
                  height:
                      status == true ? Get.height * 0.06 : Get.height * 0.03,
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

class PopularFilterTab extends StatelessWidget {
  final bool status;

  PopularFilterTab({super.key, required this.status});
  final insuranceController = Get.put(InsuranceController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 8),
            child: Text(
              'Popular Filter',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Obx(
            () => Column(
              children: insuranceController.populerFilter.map((facility) {
                return SizedBox(
                  height:
                      status == true ? Get.height * 0.06 : Get.height * 0.03,
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            'Payment/insurance/funding Accepted',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
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
