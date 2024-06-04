import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:health_care/screens/Home/View/home_List_screen.dart';
import 'package:health_care/screens/Insurance/view/insurance.dart';
import 'package:health_care/utils/app_asset.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_string.dart';
import 'package:health_care/utils/app_text_style.dart';
import 'package:health_care/utils/helper.dart';
import 'package:health_care/utils/screen_utils.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Column(
        children: [
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Stack(children: [
                  Image.asset(
                    AppAsset.drawerImg,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.s12, vertical: Sizes.s14),
                    child: Column(
                      children: [
                        verticalSpacing(55),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                    height: Sizes.s80.h,
                                    width: Sizes.s80.h,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              AssetImage(AppAsset.doctorMale),
                                        ))),
                              ],
                            ),
                            horizontalSpacing(10),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ScreenUtil().setVerticalSpacing(10),
                                Text("Jaydip Godhani",
                                    style: AppTextStyle.regulerS14Black
                                        .copyWith(color: AppColor.whiteColor)),
                                Text("abcd@gmail.com",
                                    style: AppTextStyle.reguler12grey
                                        .copyWith(color: AppColor.whiteColor))
                              ],
                            ),
                          ],
                        ),
                        ScreenUtil().setVerticalSpacing(20),
                        _DrawerMenuListTile.asset(
                          title: AppStrings.aboutDoctor,
                          onTap: () {
                            //Navigator.pop(context);
                            Get.to(() => HomeListScreen());
                          },
                          child: Image.asset(
                            AppAsset.frame,
                            scale: 4,
                          ),
                        ),
                        _DrawerMenuListTile.asset(
                          title: AppStrings.insurance,
                          onTap: () {
                            //Navigator.pop(context);
                            Get.to(() => InsuranceScreen());
                          },
                          child: Image.asset(
                            AppAsset.frame,
                            scale: 4,
                          ),
                        ),
                        _DrawerMenuListTile.asset(
                          title: AppStrings.help,
                          onTap: () {},
                          child: const Icon(
                            Icons.help,
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DrawerMenuListTile extends StatelessWidget {
  final Widget child;
  final String title;
  final VoidCallback onTap;

  _DrawerMenuListTile.asset({
    required this.onTap,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: child,
      title: Text(
        title,
        style:
            AppTextStyle.appBarTextTitle.copyWith(color: AppColor.whiteColor),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColor.whiteColor,
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}
