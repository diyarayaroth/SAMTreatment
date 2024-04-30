import 'package:get/get.dart';
import 'package:health_care/utils/app_color.dart';

void showToast({required String title, bool status = false}) {
  Get.showSnackbar(GetSnackBar(
    duration: const Duration(seconds: 3),
    message: title,
    backgroundColor: status ? AppColor.green : AppColor.red,
  ));
}
