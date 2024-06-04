// import 'package:flutter/material.dart';

// class InsuranceScreen extends StatefulWidget {
//   const InsuranceScreen({super.key});

//   @override
//   State<InsuranceScreen> createState() => _InsuranceScreenState();
// }

// class _InsuranceScreenState extends State<InsuranceScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:health_care/screens/Home/Controller/Home_screen_controller.dart';
import 'package:health_care/screens/Insurance/controller/insurance_controller.dart';
import 'package:health_care/screens/Insurance/controller/place_search_controller.dart';
import 'package:health_care/screens/Insurance/view/filter_screen.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:health_care/widgets/custom/custom_ins_card.dart';
import 'package:health_care/widgets/custom/custom_shimmer.dart';
import 'package:health_care/widgets/primary/primary_appbar.dart';
import 'package:health_care/widgets/primary/primary_padding.dart';
import 'package:health_care/widgets/primary/primary_textfield.dart';

class InsuranceScreen extends StatefulWidget {
  const InsuranceScreen({
    super.key,
  });

  @override
  State<InsuranceScreen> createState() => _InsuranceScreenState();
}

class _InsuranceScreenState extends State<InsuranceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final insuranceController = Get.put(InsuranceController());
  final homeScreenController = Get.put(HomeScreenController());
  final searchController = Get.put(PlaceSearchController());

  // void openDrawer() {
  //   _scaffoldKey.currentState?.openDrawer();
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.whiteColor,
      // drawer: Drawer(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   width: ScreenUtil().screenWidth * 0.8,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       topRight: Radius.circular(Sizes.s20.r),
      //       bottomRight: Radius.circular(Sizes.s20.r),
      //     ),
      //   ),
      //   child: const DrawerWidget(),
      // ),
      appBar: SecondaryAppBar(
        isLeading: false,
        title: AppStrings.searchForTreatment,
        action: IconButton(
          icon: const Icon(
            Icons.filter_alt_outlined,
            size: 25,
          ),
          tooltip: 'Open Dailog',
          onPressed: () {
            Get.to(() => MyTabScreen());
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: PrimaryPadding(
          child: Column(
            children: [
              verticalSpacing(10),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.colorF1F1F1,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Column(
                    children: [
                      PrimaryTextField(
                        controller: insuranceController.zipCodeController,
                        onChanged: (value) {
                          if (value.isEmpty) {
                            insuranceController.isSearching.value = false;
                          } else {
                            searchController.getPredictions(value);
                            insuranceController.isSearching.value = true;
                          }
                        },
                        hintText:
                            insuranceController.zipCodeController.text.isEmpty
                                ? 'Enter Zip Code Or City'
                                : insuranceController.zipCodeController.text,
                        prefix: const Icon(Icons.search),
                        color: Colors.white,
                      ),
                      verticalSpacing(10),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.check_box,
                                  color: AppColor.primaryColor,
                                  size: 20,
                                ),
                                horizontalSpacing(5),
                                const Text('Distance'),
                                horizontalSpacing(10),
                                //select distance dropdown
                                Container(
                                  height: 30,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: AppColor.primaryColor,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: DropdownButton<String>(
                                    value:
                                        insuranceController.dropdownValue.value,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      height: 0,
                                    ),
                                    onChanged: (String? value) {
                                      insuranceController.dropdownValue.value =
                                          value!;
                                    },
                                    items: insuranceController.distanceList
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            ),
                            CustomButton(
                                height: context.height * 0.04,
                                width: context.width * 0.2,
                                borderRadius: 5,
                                text: "Search",
                                onTap: () {
                                  insuranceController.getInsuranceList();
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpacing(10),
              Expanded(
                child: ListView(
                  children: [
                    verticalSpacing(10),
                    Obx(
                      () => Visibility(
                        visible: insuranceController.isSearching.value == true,
                        child: Container(
                          height: context.height * 0.4,
                          child: (ListView.builder(
                            itemCount: searchController.predictions.length,
                            itemBuilder: (context, index) {
                              final prediction =
                                  searchController.predictions[index];
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(prediction.description ?? ""),
                                    tileColor: AppColor.colorF1F1F1,
                                    leading:
                                        const Icon(Icons.location_on, size: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    onTap: () async {
                                      try {
                                        PlacesDetailsResponse detail =
                                            await searchController
                                                .getPlaceDetails(
                                                    prediction.placeId ?? "");
                                        final lat = detail
                                            .result.geometry?.location.lat;
                                        final lng = detail
                                            .result.geometry?.location.lng;
                                        final postalCode =
                                            await searchController
                                                .getPostalCode(lat!, lng!);

                                        insuranceController
                                                .zipCodeController.text =
                                            searchController.address.value;
                                        insuranceController.zipCode.value =
                                            postalCode;
                                        insuranceController.latlong.value =
                                            "$lat,$lng";

                                        debugPrint(
                                            "Check my postal code ${insuranceController.zipCode.value}");
                                        insuranceController.isSearching.value =
                                            false;

                                        // here i want to close keyboard
                                        FocusScope.of(context).unfocus();
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Failed to fetch place details')),
                                        );
                                      }
                                    },
                                  ),
                                  verticalSpacing(5)
                                ],
                              );
                            },
                          )),
                        ),
                      ),
                    ),
                    ListTileTheme(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ExpansionTile(
                          title: Row(
                            children: [
                              const Icon(
                                Icons.filter_alt_sharp,
                                size: 25,
                                color: AppColor.color00539F,
                              ),
                              horizontalSpacing(5),
                              Text(
                                'Filter By',
                                style: AppTextStyle.appBarTextTitle.copyWith(
                                  fontSize: 16,
                                  color: AppColor.blackColor,
                                ),
                              ),
                            ],
                          ),
                          children: [
                            FacilityTab(
                              status: false,
                            ),
                            const Divider(
                              color: Colors.grey,
                              thickness: 1,
                            ),
                            PopularFilterTab(
                              status: false,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomButton(
                                  width: context.width * 0.3,
                                  height: context.height * 0.05,
                                  borderRadius: 5,
                                  text: 'Search',
                                  onTap: () {},
                                ),
                                CustomButton(
                                  width: context.width * 0.3,
                                  height: context.height * 0.05,
                                  borderRadius: 5,
                                  text: 'More Filters',
                                  onTap: () {},
                                ),
                              ],
                            ),
                            verticalSpacing(5),
                          ],
                        ),
                      ),
                    ),
                    verticalSpacing(10),
                    Obx(
                      () => Visibility(
                        visible: insuranceController.filterChipList
                            .any((element) => element.isChecked.value == true),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 5,
                            children: [
                              ...insuranceController.filterChipList.map(
                                (e) => e.isChecked == true
                                    ? Chip(
                                        label: Text(e.name),
                                        onDeleted: () {
                                          insuranceController
                                              .filterChipList[
                                                  insuranceController
                                                      .filterChipList
                                                      .indexOf(e)]
                                              .isChecked
                                              .value = false;
                                        },
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              insuranceController.filterChipList.any(
                                      (element) =>
                                          element.isChecked.value == true)
                                  ? GestureDetector(
                                      onTap: () {
                                        insuranceController.filterChipList
                                            .forEach(
                                          (element) {
                                            element.isChecked.value = false;
                                          },
                                        );
                                      },
                                      child: Chip(
                                        label: Text(
                                          'Clear All',
                                          style: AppTextStyle.regulerS14Black
                                              .copyWith(
                                                  color: AppColor.whiteColor),
                                        ),
                                        backgroundColor: AppColor.blackColor,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Obx(
                        () => insuranceController.isLoading.value == true
                            ? shimmerEffect()
                            : insuranceController.getInsListRes.isEmpty
                                ? noData()
                                : ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: insuranceController
                                        .getInsListRes.length,
                                    padding: EdgeInsets.symmetric(
                                        vertical: Sizes.s10.h),
                                    itemBuilder: (context, index) {
                                      return InsuranceComponent(
                                        providerElement: insuranceController
                                            .getInsListRes[index],
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(height: 10);
                                    },
                                  ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noData() {
    return Column(
      children: [
        verticalSpacing(10),
        Row(
          children: [
            Image.asset(
              AppAsset.instructionIcon,
              scale: 3,
            ),
            horizontalSpacing(10),
            Text(
              "instructions",
              style: AppTextStyle.appBarTextTitle,
            ),
          ],
        ),
        verticalSpacing(15),
        const Text(
            "Find confidential and anonymous resource for locating treatment facilities for mental and substance use disorders in the United States and its territories")
      ],
    );
  }
}
