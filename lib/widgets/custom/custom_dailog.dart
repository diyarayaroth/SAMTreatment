import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care/Services/Shared_pref.dart';
import 'package:health_care/screens/Home/View/home_List_screen.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/widgets/custom/custom_button.dart';
import 'package:health_care/widgets/custom/custom_sizebox.dart';
import 'package:health_care/widgets/primary/primary_textfield.dart';
import '../../utils/app_sizes.dart';

class CustomDailog extends StatefulWidget {
  final String title;
  final TextEditingController? controller;

  const CustomDailog({
    super.key,
    required this.title,
    this.controller,
  });

  static Future<bool> show(
      BuildContext context, String title, String subTitle) async {
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CustomDailog(title: title),
    );
  }

  @override
  State<CustomDailog> createState() => _CustomDailogState();
}

class _CustomDailogState extends State<CustomDailog> {
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
                SizedBoxH20(),
                Center(
                  child: Image.asset(
                    AppAsset.addZip,
                    height: Sizes.s120,
                    width: Sizes.s120,
                  ),
                ),
                SizedBoxH34(),
                Text(
                  widget.title,
                  style: AppTextStyle.regulerS14Black,
                ),
                SizedBoxH10(),
                PrimaryTextField(
                  hintText: "Enter Zip Code",
                  controller: widget.controller,
                ),
                SizedBoxH20(),
                CustomButton(
                    text: "Start",
                    onTap: () {
                      debugPrint(
                          "Zip code check===> ${widget.controller!.text.toString()}");
                      Preferances.setString("zipcode", widget.controller!.text);
                      //Preferances.setString("zipcode", widget.controller!.text);
                      Get.off(HomeListScreen());
                    },
                    borderRadius: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
