import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Home/Controller/Home_screen_controller.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/utils/screen_utils.dart';
import 'package:health_care/widgets/custom/custom_doctor_card.dart';
import 'package:health_care/widgets/custom/custom_dailog.dart';
import 'package:health_care/widgets/custom/custom_shimmer.dart';
import 'package:health_care/widgets/custom/drawer_widget.dart';
import 'package:health_care/widgets/primary/primary_appbar.dart';
import 'package:health_care/widgets/primary/primary_padding.dart';
import 'package:health_care/widgets/primary/primary_textfield.dart';

class HomeListScreen extends StatefulWidget {
  const HomeListScreen({
    super.key,
  });

  @override
  State<HomeListScreen> createState() => _HomeListScreenState();
}

class _HomeListScreenState extends State<HomeListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final homeController = Get.put(HomeScreenController());
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.whiteColor,
      drawer: Drawer(
        backgroundColor: Colors.white,
        elevation: 0,
        width: ScreenUtil().screenWidth * 0.8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Sizes.s20.r),
            bottomRight: Radius.circular(Sizes.s20.r),
          ),
        ),
        child: const DrawerWidget(),
      ),
      appBar: SecondaryAppBar(
        title: AppStrings.bookAppointment,
        isLeading: true,
        leadingIcon: Icons.menu,
        onBackPressed: () {
          openDrawer();
        },
        action: IconButton(
          icon: const Icon(
            Icons.location_on_outlined,
            size: 25,
          ),
          tooltip: 'Open shopping cart',
          onPressed: () {
            homeController.filteredTopics.clear();
            Get.dialog(CustomDailog(
              title: 'Add Zipcode',
              controller: homeController.zipCodeController,
            ));
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: PrimaryPadding(
          child: Column(
            children: [
              verticalSpacing(10),
              PrimaryTextField(
                controller: homeController.searchController,
                onChanged: (value) {
                  debugPrint('on changed value : $value');
                  homeController.searchQuery(value);
                },
                hintText: AppStrings.searchDoctor,
                prefix: Icon(Icons.search),
              ),
              verticalSpacing(10),
              Expanded(
                child: Obx(
                  () => homeController.isLoading.value == true
                      ? shimmerEffect()
                      : homeController.filteredTopics.isEmpty
                          ? const Center(
                              child: Text('Invalid zipcode or fips provided'),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: homeController.filteredTopics.length,
                              padding:
                                  EdgeInsets.symmetric(vertical: Sizes.s10.h),
                              itemBuilder: (context, index) {
                                return DoctorComponent(
                                  providerElement:
                                      homeController.filteredTopics[index],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 10);
                              },
                            ),
                ),
              ),

              // SizedBoxH20(),
            ],
          ),
        ),
      ),
    );
  }
}
