import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/route/routes.dart';
import 'package:hiwash_customer/styling/app_theam.dart';
import 'package:hiwash_customer/test_screen.dart';

import 'featuers/dashboard/view/dashbord_screen.dart';
import 'language/languages.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
         locale:Locale('en','US'),
          translations: Languages(),
          debugShowCheckedModeBanner: false,
          title: 'Hiwash customer',
          theme: LightTheme.theme(),
    // home: HomeScreen(),
        initialRoute: RouteStrings.splashScreen,
          getPages: Routes.pages,
        );
      },
    );
  }
}
