import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:health_care/screens/Home/controller/insurance_controller.dart';
import 'package:health_care/screens/Home/controller/place_search_controller.dart';
import 'package:health_care/screens/Home/view/filter_screen.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/constant.dart';
import 'package:health_care/utils/function.dart';
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
  final searchController = Get.put(PlaceSearchController());

  @override
  void initState() {
    super.initState();
    CommonFunctions.checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: AppColor.whiteColor,

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
            insuranceController.zipCodeController.text.isNotEmpty
                ? Get.to(() => const FilterScreen())
                : CommonFunctions.toast("Please enter zip code or city");
          },
        ),
      ),
      // ignore: deprecated_member_use
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Column(
                    children: [
                      PrimaryTextField(
                        controller: insuranceController.zipCodeController,
                        onChanged: (value) async {
                          if (await CommonFunctions.checkConnectivity()) {
                            // Your code here if connectivity is true
                            if (value.isEmpty) {
                              insuranceController.isSearching.value = false;
                            } else {
                              searchController.getPredictions(value);
                              insuranceController.isSearching.value = true;
                            }
                          }
                        },
                        hintText: 'Enter Zip Code Or City',
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
                                      insuranceController.aPIcall();
                                    },
                                    items: distanceList
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
                                  insuranceController.isFirst.value = false;
                                  insuranceController.aPIcall();
                                })
                          ],
                        ),
                      ),
                      verticalSpacing(10),
                      Obx(
                        () => Visibility(
                          visible:
                              insuranceController.isSearching.value == true,
                          child: Container(
                            height: context.height * 0.4,
                            child: (ListView.builder(
                              itemCount: searchController.predictions.length,
                              itemBuilder: (context, index) {
                                final prediction =
                                    searchController.predictions[index];
                                return ListTile(
                                  title: Text(prediction.description ?? ""),
                                  tileColor: AppColor.colorF1F1F1,
                                  leading:
                                      const Icon(Icons.location_on, size: 20),
                                  onTap: () async {
                                    try {
                                      PlacesDetailsResponse detail =
                                          await searchController
                                              .getPlaceDetails(
                                                  prediction.placeId ?? "");
                                      final lat =
                                          detail.result.geometry?.location.lat;
                                      final lng =
                                          detail.result.geometry?.location.lng;
                                      final postalCode = await searchController
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
                                      FocusScope.of(context).unfocus();
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Failed to fetch place details'),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            )),
                          ),
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
                          onExpansionChanged: (value) {
                            insuranceController.isFacilityTab.value = value;
                          },
                          iconColor: AppColor.blackColor,
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
                                  width: context.width * 0.25,
                                  height: context.height * 0.04,
                                  borderRadius: 5,
                                  text: 'Search',
                                  onTap: () {
                                    insuranceController.isFirst.value = false;
                                    insuranceController.aPIcall();
                                  },
                                ),
                                CustomButton(
                                  width: context.width * 0.25,
                                  height: context.height * 0.04,
                                  borderRadius: 5,
                                  text: 'More Filters',
                                  onTap: () {
                                    insuranceController
                                            .zipCodeController.text.isNotEmpty
                                        ? Get.to(() => const FilterScreen())
                                        : CommonFunctions.toast(
                                            "Please enter zip code or city");
                                  },
                                ),
                              ],
                            ),
                            verticalSpacing(10),
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
                            spacing: 2,
                            children: [
                              insuranceController.dropdownValue.value.isNotEmpty
                                  ? Chip(
                                      label: Text(
                                        insuranceController.dropdownValue.value,
                                        style: AppTextStyle.regulerS14Black
                                            .copyWith(
                                                color: AppColor.blackColor),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              ...insuranceController.filterChipList.map(
                                (e) => e.isChecked.isTrue
                                    ? Chip(
                                        label: Text(e.name),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              insuranceController.filterChipList.any(
                                      (element) =>
                                          element.isChecked.value == true)
                                  ? GestureDetector(
                                      onTap: () {
                                        for (var element in insuranceController
                                            .filterChipList) {
                                          element.isChecked.value = false;
                                        }

                                        insuranceController.filterChipList[0]
                                            .isChecked.value = true;
                                        insuranceController.aPIcall();
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
                    verticalSpacing(10),
                    Obx(
                      () => insuranceController.isLoading.value == true
                          ? shimmerEffect()
                          : insuranceController.getInsListRes.isEmpty
                              ? insuranceController.isFirst.value
                                  ? noData()
                                  : noDataSearch()
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      insuranceController.getInsListRes.length,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Sizes.s10.h),
                                  itemBuilder: (context, index) {
                                    return InsuranceComponent(
                                      providerElement: insuranceController
                                          .getInsListRes[index],
                                      facilityType:
                                          '${insuranceController.getInsListRes[index].typeFacility}',
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(height: 10);
                                  },
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
            const Text(
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

  Widget noDataSearch() {
    return Column(
      children: [
        verticalSpacing(10),
        Center(
          child: Text(
            "No results found.",
            style: AppTextStyle.appBarTextTitle.copyWith(
              color: AppColor.red,
            ),
          ),
        ),
        verticalSpacing(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search Tips:",
              style: AppTextStyle.appBarTextTitle.copyWith(
                color: AppColor.red,
              ),
            ),
            verticalSpacing(10),
            Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: AppColor.blackColor,
                  size: 10,
                ),
                horizontalSpacing(10),
                const Text(
                  "Expand your search range",
                  style: AppTextStyle.regulerS14Black,
                ),
              ],
            ),
            verticalSpacing(10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.circle,
                    color: AppColor.lightGrey,
                    size: 10,
                  ),
                  horizontalSpacing(10),
                  Text(
                    "Increase the Distance option value",
                    style: AppTextStyle.reguler12grey.copyWith(
                      color: AppColor.blackColor,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacing(10),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const Icon(
                    Icons.circle_sharp,
                    color: AppColor.lightGrey,
                    size: 10,
                  ),
                  horizontalSpacing(10),
                  Text(
                    "Deselect the Distance, County or State constraint",
                    style: AppTextStyle.reguler12grey.copyWith(
                      color: AppColor.blackColor,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacing(10),
            Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: AppColor.blackColor,
                  size: 10,
                ),
                horizontalSpacing(10),
                const Text(
                  "Include more facility types",
                  style: AppTextStyle.regulerS14Black,
                ),
              ],
            ),
            verticalSpacing(10),
            Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: AppColor.blackColor,
                  size: 10,
                ),
                horizontalSpacing(10),
                const Text(
                  "Reduce the number of selected filter types",
                  style: AppTextStyle.regulerS14Black,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
