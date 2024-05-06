import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/screens/Home/Controller/Home_screen_controller.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/utils/validation_mixin.dart';
import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:health_care/widgets/primary/primary_textfield.dart';
import '../../utils/app_sizes.dart';

class CustomDailog extends StatefulWidget {
  final String title;
  final bool isBack;
  final TextEditingController? controller;

  const CustomDailog({
    super.key,
    required this.title,
    required this.isBack,
    this.controller,
  });

  static Future<bool> show(
      BuildContext context, String title, String subTitle, bool isBack) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CustomDailog(
        title: title,
        isBack: isBack,
      ),
    );
  }

  @override
  State<CustomDailog> createState() => _CustomDailogState();
}

class _CustomDailogState extends State<CustomDailog> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final homeController = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(
            horizontal: Sizes.s26.w,
            vertical: Sizes.s20.h,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.s12.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.s18.w,
              vertical: Sizes.s20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    widget.isBack
                        ? InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: Sizes.s30,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                verticalSpacing(20),
                Center(
                  child: Image.asset(
                    AppAsset.addZip,
                    height: Sizes.s120,
                    width: Sizes.s120,
                  ),
                ),
                verticalSpacing(34),
                Text(
                  widget.title,
                  style: AppTextStyle.regulerS14Black,
                ),
                verticalSpacing(10),
                Form(
                  key: _formKey,
                  child: PrimaryTextField(
                    hintText: "Enter Zip Code",
                    controller: widget.controller,
                    validator: zipCodeValidation,
                    keyboardInputType: TextInputType.number,
                    maxLength: 5,
                  ),
                ),
                verticalSpacing(10),
                CustomButton(
                  text: "Start",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      homeController.filteredTopics.clear();
                      debugPrint(
                          "Zip code check===> ${homeController.zipCodeController.text}");

                      homeController.getDoctorList(int.parse(
                          "${homeController.zipCodeController.text.replaceAll('"', '').replaceAll('"', '').toString()}"));
                      Get.back();
                    }
                  },
                  borderRadius: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
