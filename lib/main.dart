import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hiwash_customer/featuers/auth/auth_controller/auth_controller.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/route/routes.dart';
import 'package:hiwash_customer/styling/app_theam.dart';
import 'featuers/notification/services/notification_services.dart';
import 'firebase_options.dart';
import 'language/languages.dart';
import 'network_manager/local_storage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationServices notificationServices = NotificationServices();
  await notificationServices.firebaseInit();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await GetStorage.init(

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String? localeCode = LocalStorage().getSavedLocale();


    Locale initialLocale = localeCode == 'ar'
        ? const Locale('ar', 'SA')
        : localeCode == 'en'
        ? const Locale('en', 'US')
        : Get.deviceLocale ?? const Locale('en', 'US');


    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          locale: initialLocale,
          translations: Languages(),
          fallbackLocale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          title: 'Hiwash customer',
          theme: LightTheme.theme(),
          initialRoute: RouteStrings.splashScreen,
          getPages: Routes.pages,
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: child!,
            );
          },
        );
      },
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        String? uid=LocalStorage().getUserId();
         if(LocalStorage().getUserId()!=null && uid!.isNotEmpty){
            AuthController authController=Get.isRegistered<AuthController>()?Get.find():Get.put(AuthController());
            authController.refreshToken();
         }
        break;
      case AppLifecycleState.inactive:
      //save time
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }


}


