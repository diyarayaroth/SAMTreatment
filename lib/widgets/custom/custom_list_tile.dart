// ignore_for_file: must_be_immutable, prefer_const_constructors, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Home/controller/insurance_controller.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_string.dart';

class ListTileWidget extends StatefulWidget {
  String? title;

  ListTileWidget({
    super.key,
    this.title,
  });

  @override
  State<ListTileWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListTileWidget> {
  final insuranceController = Get.put(InsuranceController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).copyWith(
      dividerColor: Colors.transparent,
    );
    return Theme(
        data: theme,
        child: Obx(
          () => ListTileTheme(
            child: ExpansionTile(
              title: Row(
                children: [
                  Text(
                    widget.title ?? "",
                  ),
                  Visibility(
                    visible: insuranceController.isSubstanceUse.isTrue,
                    child: Text(
                      AppStrings.substanceUse,
                    ),
                  ),
                  Visibility(
                    visible: insuranceController.isMentalHealth.isTrue,
                    child: Text(
                      AppStrings.mentalHealth,
                    ),
                  ),
                ],
              ),
              children: [
                Container(
                  height: Get.height * 0.1,
                  child: Row(
                    children: [
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            insuranceController.isSubstanceUse.value =
                                !insuranceController.isSubstanceUse.value;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: AppColor.lightGrey,
                              ),
                              color: insuranceController.isSubstanceUse.isTrue
                                  ? AppColor.lightGrey
                                  : AppColor.whiteColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(AppStrings.substanceUseSText),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            insuranceController.isMentalHealth.value =
                                !insuranceController.isMentalHealth.value;
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: AppColor.lightGrey,
                              ),
                              color: insuranceController.isMentalHealth.isTrue
                                  ? AppColor.lightGrey
                                  : AppColor.whiteColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(AppStrings.mentalHealthText),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
