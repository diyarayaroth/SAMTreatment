import 'package:flutter/material.dart';
import 'package:health_care/utils/create_material_color.dart';

import 'app_color.dart';

class ThemeUtils {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColor.primaryColor,
      //tabBarTheme: lightTabBarTheme,
      dialogBackgroundColor: AppColor.whiteColor,
      scaffoldBackgroundColor: AppColor.whiteColor,
      //appBarTheme: lightAppBarTheme,
      brightness: Brightness.light,
      cardColor: AppColor.lightGrey,
      //bottomNavigationBarTheme: lightBottomNavigationBarTheme,
      //inputDecorationTheme: lightInputDecorationTheme,
      dividerColor: AppColor.darkGrey,
      colorScheme: const ColorScheme.light(),
      primarySwatch: createMaterialColor(AppColor.primaryColor),
      fontFamily: "Poppins",
    );
  }
}
