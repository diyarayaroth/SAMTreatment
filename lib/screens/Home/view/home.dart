import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:health_care/screens/Home/controller/insurance_controller.dart';
import 'package:health_care/screens/Home/controller/place_search_controller.dart';
import 'package:health_care/screens/Home/view/filter_screen.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
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
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    CommonFunctions.checkConnectivity();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        insuranceController.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      backgroundColor: AppColor.whiteColor,

      appBar: SecondaryAppBar(
        isLeading: true,
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
      body: PrimaryPadding(
        child: Column(
          children: [
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
                    Obx(
                      () => PrimaryTextField(
                        controller: insuranceController.zipCodeController,
                        onTap: () {
                          if (insuranceController
                              .zipCodeController.value.text.isNotEmpty) {
                            insuranceController.isBack.value = true;
                          } else {
                            insuranceController.isBack.value = false;
                          }
                        },
                        onChanged: (value) async {
                          if (await CommonFunctions.checkConnectivity()) {
                            if (value.isEmpty) {
                              insuranceController.isSearching.value = false;
                            } else {
                              searchController.getPredictions(value);
                              insuranceController.isSearching.value = true;
                              insuranceController.isBack.value = true;
                            }
                          }
                        },
                        hintText: 'Enter Zip Code Or City',
                        prefix: insuranceController.isBack.value == false
                            ? const Icon(Icons.search)
                            : InkWell(
                                onTap: () {
                                  insuranceController.zipCodeController.clear();
                                  insuranceController.isSearching.value = false;
                                  insuranceController.isBack.value = false;
                                  insuranceController.isFirst.value = true;
                                  insuranceController.getInsListRes.obs.value
                                      .clear();
                                },
                                child: const Icon(Icons.cancel)),
                        color: Colors.white,
                      ),
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
                                  items: AppConst.distanceList
                                      .map<DropdownMenuItem<String>>(
                                    (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
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
                    Obx(
                      () => Visibility(
                        visible: insuranceController.isSearching.value == true,
                        child: SizedBox(
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
                                        await searchController.getPlaceDetails(
                                            prediction.placeId ?? "");
                                    final lat =
                                        detail.result.geometry?.location.lat;
                                    final lng =
                                        detail.result.geometry?.location.lng;
                                    final postalCode = await searchController
                                        .getPostalCode(lat!, lng!);

                                    insuranceController.zipCodeController.text =
                                        searchController.address.value;
                                    insuranceController.zipCode.value =
                                        postalCode;
                                    insuranceController.latlong.value =
                                        "$lat,$lng";
                                    insuranceController.isSearching.value =
                                        false;
                                    // ignore: use_build_context_synchronously
                                    FocusScope.of(context).unfocus();
                                  } catch (e) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
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
            Obx(
              () => Expanded(
                  child: ListView(
                controller: scrollController,
                physics: insuranceController.getInsListRes.obs.value.isEmpty
                    ? const NeverScrollableScrollPhysics()
                    : const AlwaysScrollableScrollPhysics(),
                children: [
                  Column(
                    // padding: const EdgeInsets.all(0),
                    children: [
                      GestureDetector(
                        onTap: () {
                          insuranceController.isOpen.value =
                              !insuranceController.isOpen.value;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 8,
                                ),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.filter_alt_sharp,
                                          size: 25,
                                          color: AppColor.color00539F,
                                        ),
                                        horizontalSpacing(5),
                                        Text(
                                          'Filter By',
                                          style: AppTextStyle.appBarTextTitle
                                              .copyWith(
                                            fontSize: 16,
                                            color: AppColor.blackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Icon(
                                      insuranceController.isOpen.value
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: AppColor.color00539F,
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: insuranceController.isOpen.value,
                                child: Column(
                                  children: [
                                    const Divider(
                                      height: 0.5,
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
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
                                    verticalSpacing(10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomButton(
                                            width: context.width * 0.35,
                                            height: context.height * 0.042,
                                            borderRadius: 5,
                                            text: 'More Filters',
                                            onTap: () {
                                              insuranceController
                                                      .zipCodeController
                                                      .text
                                                      .isNotEmpty
                                                  ? Get.to(() =>
                                                      const FilterScreen())
                                                  : CommonFunctions.toast(
                                                      "Please enter zip code or city");
                                            },
                                          ),
                                          CustomButton(
                                            width: context.width * 0.35,
                                            height: context.height * 0.042,
                                            borderRadius: 5,
                                            text: 'Apply Filters',
                                            onTap: () {
                                              insuranceController
                                                  .isFirst.value = false;
                                              insuranceController.aPIcall();
                                              insuranceController.isOpen.value =
                                                  !insuranceController
                                                      .isOpen.value;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    verticalSpacing(10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpacing(5),
                      Obx(
                        () => Visibility(
                          visible: insuranceController.filterChipList.any(
                              (element) => element.isChecked.value == true),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                if (insuranceController
                                    .dropdownValue.value.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: Chip(
                                      label: Text(
                                        insuranceController.dropdownValue.value,
                                        style: AppTextStyle.regulerS14Black
                                            .copyWith(
                                          color: AppColor.blackColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ...insuranceController.filterChipList.map(
                                  (e) {
                                    if (e.isChecked.isTrue) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        child: Chip(
                                          label: Text(e.name),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                ),
                                if (insuranceController.filterChipList.any(
                                    (element) =>
                                        element.isChecked.value == true))
                                  GestureDetector(
                                    onTap: () {
                                      for (var element in insuranceController
                                          .filterChipList) {
                                        element.isChecked.value = false;
                                      }
                                      insuranceController.filterChipList[0]
                                          .isChecked.value = true;
                                      insuranceController.aPIcall();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 3),
                                      child: Chip(
                                        label: Text(
                                          'Clear All',
                                          style: AppTextStyle.regulerS14Black
                                              .copyWith(
                                            color: AppColor.whiteColor,
                                          ),
                                        ),
                                        backgroundColor: AppColor.blackColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  insuranceController.isLoading.value == true &&
                          insuranceController.getInsListRes.obs.value.isEmpty
                      ? shimmerEffect(5)
                      : insuranceController.getInsListRes.obs.value.isEmpty
                          ? insuranceController.isFirst.obs.value.isTrue
                              ? noData()
                              : noDataSearch()
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: insuranceController
                                      .getInsListRes.length +
                                  (insuranceController.isLoading.value ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (index <
                                    insuranceController.getInsListRes.length) {
                                  return InsuranceComponent(
                                    providerElement: insuranceController
                                        .getInsListRes[index],
                                    facilityType:
                                        '${insuranceController.getInsListRes[index].typeFacility}',
                                  );
                                } else {
                                  return shimmerEffect(1);
                                }
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: 10);
                              },
                            ),
                ],
              )),
            ),
            // developedBy(),
          ],
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
            "In the Your Location field enter an address, city, zip code, and/or facility name and select a value from the list to set your location.\n\nTo limit the number of records returned, utilize the State, County, or Distance filter options. Additional filtering options can be found along the left side under the Filter by section (Facility Name, Facility Types, etc.) and will automatically filter the search results when entered.")
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.circle_sharp,
                    color: AppColor.lightGrey,
                    size: 10,
                  ),
                  horizontalSpacing(10),
                  Expanded(
                    child: Text(
                      "Deselect the Distance, County or State constraint",
                      style: AppTextStyle.reguler12grey.copyWith(
                        color: AppColor.blackColor,
                      ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.circle,
                  color: AppColor.blackColor,
                  size: 10,
                ),
                horizontalSpacing(10),
                Expanded(
                  child: const Text(
                    "Reduce the number of selected filter types",
                    style: AppTextStyle.regulerS14Black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

Widget developedBy() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Developed by :",
                      style: AppTextStyle.regulerS14Black
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
                  horizontalSpacing(5),
                  Text("Diya Rayaroth",
                      style:
                          AppTextStyle.regulerS14Black.copyWith(fontSize: 12)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Mentor & Motivator :",
                      style: AppTextStyle.regulerS14Black
                          .copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
                  horizontalSpacing(5),
                  Text("Norma Lopez, LCSWR",
                      style:
                          AppTextStyle.regulerS14Black.copyWith(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
