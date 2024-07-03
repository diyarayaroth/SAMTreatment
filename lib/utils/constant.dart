import 'package:health_care/utils/screen_utils.dart';

import 'app_sizes.dart';

const double kBorderRadius = 16;
const double roundBorderRadius = 50;
double kPadding = ScreenUtil().setHeight(15);
double textFieldBorderRadius = Sizes.s12.r;
const String kErrorMessage = 'Something went wrong. Please try again later.';

class AppConst {
// google API KEY //
  static String googleApiKey = "AIzaSyBzn3ryihAgBbqcZbmyzMe894DgH_TeV4w";

  // App Name //
  static String kAppName = 'SAM TREATMENT';

  static List<String> distanceList = [
    '5 miles',
    '10 miles',
    '15 miles',
    '20 miles',
    '25 miles',
    '50 miles',
    '100 miles',
  ];
}
