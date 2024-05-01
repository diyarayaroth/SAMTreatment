import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:health_care/screens/Home/View/home_List_screen.dart';
import 'package:health_care/screens/splash/view/splash_screen.dart';
import 'package:health_care/utils/screen_utils.dart';
import 'package:health_care/utils/theme_utils.dart';

void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final botToastBuilder = BotToastInit();
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       theme: ThemeUtils.lightTheme,
//       title: 'Flutter Demo',
//       //home: HistoryScreen(),
//       // home: AppointmentScreen(),
//       //home: BookAppointmentScreen(),
//       home: SplashScreen(),
//       builder: (context, child) {
//         return ScrollConfiguration(
//           behavior: const _ScrollBehaviorModified(),
//   child: LayoutBuilder(
//     builder: (BuildContext context, BoxConstraints constraints) {
//       ScreenUtil.init(constraints,
//           designSize:
//               Size(constraints.maxWidth, constraints.maxHeight));
//       child = botToastBuilder(context, child);
//       return child ?? const SizedBox.shrink();
//     },
//   ),
// );
//       },
//       //home: First(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: GetMaterialApp(
        title: 'Health Care',
        debugShowCheckedModeBanner: false,
        theme: ThemeUtils.lightTheme,
        home: const SplashScreen(),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: const _ScrollBehaviorModified(),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                ScreenUtil.init(constraints,
                    designSize:
                        Size(constraints.maxWidth, constraints.maxHeight));
                child = botToastBuilder(context, child);
                return child ?? const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );

    /* MaterialApp.router(
          debugShowCheckedModeBanner: false,
         
          builder: (context, widget) {
            return ScrollConfiguration(
              behavior: ,
              // ignore: deprecated_member_use
              child: MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor:  ).copyWith(boldText: false), child: widget!),
            );
          },
        ); */

    //  GetMaterialApp(
    //   title: 'Flutter Demo',
    //   debugShowCheckedModeBanner: false,
    // theme:
    //   home: const SplashScreen(),
    // );
  }
}

class _ScrollBehaviorModified extends ScrollBehavior {
  const _ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
