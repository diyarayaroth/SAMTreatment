// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Insurance/controller/insurance_controller.dart';
import 'package:health_care/utils/app_color.dart';

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
              // tilePadding: const EdgeInsets.symmetric(horizontal: 5),

              title: Row(
                children: [
                  Text(
                    widget.title ?? "",
                  ),
                  Visibility(
                    visible: insuranceController.isSubstanceUse.isTrue,
                    child: Text(
                      "(Substance Use)",
                    ),
                  ),
                  Visibility(
                    visible: insuranceController.isMentalHealth.isTrue,
                    child: Text(
                      "(Mental Health)",
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
                            debugPrint(
                                "Check my value 51:  ${insuranceController.isSubstanceUse.value}");
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
                              child: Text("Substance Use"),
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
                            debugPrint(
                                "Check my value 51:  ${insuranceController.isMentalHealth.value}");
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
                              child: Text("Mental Health"),
                            ),
                          ),
                        ),
                      ),

                      // Add other widgets here
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
