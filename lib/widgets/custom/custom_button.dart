import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_text_style.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.txtColor,
    this.borderRadius,
    this.height,
    this.width,
    this.hovorColor,
    required this.text,
    required this.onTap,
    this.fontSize,
    this.textStyle,
    this.bgColor,
    this.icon,
    this.borderColor,
  });
  final Color? txtColor;
  final Color? hovorColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  final String text;
  final double? fontSize;
  final Color? bgColor;
  final Color? borderColor;
  final IconData? icon;

  final TextStyle? textStyle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? Sizes.s46.h,
        width: width ?? Sizes.s330.w,
        decoration: BoxDecoration(
            color: bgColor ?? AppColor.primaryColor,
            border: Border.all(color: borderColor ?? Colors.transparent),
            borderRadius: BorderRadius.circular(borderRadius ?? 0.0)),
        child: Center(
            child: icon == null
                ? Text(text,
                    style: textStyle ??
                        AppTextStyle.buttonTextStyle
                            .copyWith(color: txtColor ?? AppColor.whiteColor))
                : Icon(
                    icon,
                    color: AppColor.whiteColor,
                    size: Sizes.s18,
                  )),
      ),
    );
  }
}
