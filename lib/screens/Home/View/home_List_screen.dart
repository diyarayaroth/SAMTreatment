import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Home/Controller/Home_screen_controller.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/app_text.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/widgets/custom/custom_book_container.dart';
import 'package:health_care/widgets/custom/custom_sizebox.dart';
import 'package:health_care/widgets/primary/primary_appbar.dart';
import 'package:health_care/widgets/primary/primary_padding.dart';
import 'package:health_care/widgets/primary/primary_textfield.dart';

class HomeListScreen extends StatelessWidget {
  HomeListScreen({super.key});
  final homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      drawer: Drawer(),
      appBar: SecondaryAppBar(
        title: AppStrings.bookAppointment,
        isLeading: true,
        leadingIcon: Icons.menu,
        onBackPressed: () {
          Drawer();
        },
      ),
      body: PrimaryPadding(
        child: Column(
          children: [
            SizedBoxH10(),
            const PrimaryTextField(
              // controller: homeController.searchController,
              hintText: AppStrings.searchDoctor,
              prefix: Icon(Icons.search),
              // onChanged: (value) {
              //   homeController.getDoctorList(value);
              // },
            ),
            SizedBoxH10(),

            // Obx(
            //   () => appText(
            //     "Results for ${homeController.doctorListResponse.value.providers?.length ?? " "} Doctors",
            //     style: AppTextStyle.regulerS14Black,
            //   ),
            // ),
            // SizedBoxH20(),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      homeController.doctorListResponse.value.providers?.length,
                  padding: EdgeInsets.symmetric(vertical: Sizes.s10.h),
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        CustomBookContainer(
                          doctorName: homeController.doctorListResponse.value
                                  .providers?[index].provider?.name ??
                              '',
                          specialist: homeController.doctorListResponse.value
                                  .providers?[index].provider?.specialties ??
                              [0],
                          language: homeController.doctorListResponse.value
                                  .providers?[index].provider!.languages ??
                              [0],
                          distance: homeController.doctorListResponse.value
                                  .providers?[index].distance ??
                              0,
                          onPressed: () {},
                          number: homeController.doctorListResponse.value
                                  .providers?[index].address?.phone ??
                              '',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // SizedBoxH20(),
          ],
        ),
      ),
    );
  }
}
