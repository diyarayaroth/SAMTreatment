import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_sizes.dart';
import 'create_material_color.dart';

class AppTextStyle {
  AppTextStyle._();

  static const TextStyle headline1 = TextStyle(
    fontSize: Sizes.s28,
    fontWeight: FontWeight.w900,
    color: AppColor.whiteColor,
  );
  static const TextStyle buttonTextStyle = TextStyle(
      fontSize: Sizes.s12,
      fontWeight: FontWeight.bold,
      color: AppColor.whiteColor);

  static const TextStyle appBarTextTitle = TextStyle(
      fontSize: Sizes.s20,
      fontWeight: FontWeight.w700,
      color: AppColor.blackColor);

  static const TextStyle reguler12grey = TextStyle(
      fontSize: Sizes.s12,
      fontWeight: FontWeight.w400,
      color: AppColor.searchTextColor);

  static const TextStyle regulerS14Black = TextStyle(
      fontSize: Sizes.s14,
      fontWeight: FontWeight.w500,
      color: AppColor.blackColor);

  static const TextStyle heading18Black = TextStyle(
      fontSize: Sizes.s18,
      fontWeight: FontWeight.w900,
      color: AppColor.blackColor);
  static const TextStyle heading14Black700 = TextStyle(
      fontSize: Sizes.s14,
      fontWeight: FontWeight.w700,
      color: AppColor.blackColor);

  static const TextStyle textFieldFont = TextStyle(
      fontSize: Sizes.s16,
      fontWeight: FontWeight.w900,
      color: AppColor.blackColor);

  static const TextStyle greySubTitle = TextStyle(
      color: AppColor.greyColor,
      fontSize: Sizes.s16,
      fontWeight: FontWeight.w400);

  static const TextStyle title = TextStyle(
      fontSize: Sizes.s26,
      fontWeight: FontWeight.w700,
      color: AppColor.blackColor);

  static const TextStyle searchtextStyle = TextStyle(
      color: AppColor.searchTextColor,
      fontSize: Sizes.s14,
      fontWeight: FontWeight.w500);
}
