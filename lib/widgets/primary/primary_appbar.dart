import 'package:flutter/material.dart';
import 'package:health_care/utils/app_color.dart';
import 'package:health_care/utils/app_sizes.dart';
import 'package:health_care/utils/app_text.dart';
import 'package:health_care/utils/app_text_style.dart';

class SecondaryAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final Widget? action;
  final double? elevation;
  final bool? isLeading;
  final VoidCallback? onBackPressed;
  final IconData? leadingIcon;

  const SecondaryAppBar({
    Key? key,
    this.title,
    this.action,
    this.isLeading = true,
    this.elevation,
    this.leading,
    this.leadingIcon,
    this.onBackPressed,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _SecondaryAppBarState createState() => _SecondaryAppBarState();
}

class _SecondaryAppBarState extends State<SecondaryAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: widget.elevation,
        // centerTitle: true,
        title: appText(
          widget.title ?? "",
          style: AppTextStyle.appBarTextTitle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(child: widget.action),
          )
        ],
        leading: widget.isLeading == true
            ? IconButton(
                icon: Icon(
                  widget.leadingIcon ?? Icons.arrow_back_ios_outlined,
                  size: Sizes.s22.h,
                  color: AppColor.blackColor,
                ),
                onPressed: widget.onBackPressed ??
                    () {
                      Navigator.pop(context);
                    },
              )
            : const SizedBox.shrink());
  }
}

class TabedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final Widget? action;
  final double? elevation;
  final bool? isLeading;
  final VoidCallback? onBackPressed;
  final IconData? leadingIcon;
  final PreferredSizeWidget? bottom;

  const TabedAppBar({
    Key? key,
    this.title,
    this.action,
    this.isLeading = true,
    this.elevation,
    this.leading,
    this.leadingIcon,
    this.onBackPressed,
    this.bottom,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _TabedAppBarState createState() => _TabedAppBarState();
}

class _TabedAppBarState extends State<TabedAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: widget.elevation,
      // centerTitle: true,
      title: appText(
        widget.title ?? "",
        style: AppTextStyle.appBarTextTitle,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Center(child: widget.action),
        )
      ],
      leading: widget.isLeading == true
          ? IconButton(
              icon: Icon(
                widget.leadingIcon ?? Icons.arrow_back_ios_outlined,
                size: Sizes.s22.h,
                color: AppColor.blackColor,
              ),
              onPressed: widget.onBackPressed ??
                  () {
                    Navigator.pop(context);
                  },
            )
          : const SizedBox.shrink(),
      bottom: widget.bottom,
    );
  }
}
