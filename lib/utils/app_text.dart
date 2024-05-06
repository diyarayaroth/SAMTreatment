import 'package:flutter/cupertino.dart';

Widget appText(
  String data, {
  TextStyle? style,
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  bool softWrap = false,
  TextAlign? textAlign,
  bool isUnderLine = false,
  int? maxLines,
  bool isTextOverflow = false,
  bool isLineThrough = false,
  TextDecoration? decoration,
}) {
  return Text(data,
      overflow: isTextOverflow ? TextOverflow.ellipsis : null,
      maxLines: maxLines,
      style: style,
      textAlign: textAlign,
      softWrap: softWrap);
}
