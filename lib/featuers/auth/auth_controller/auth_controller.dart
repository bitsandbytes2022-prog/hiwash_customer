import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hiwash_customer/featuers/auth/model/get_refresh_token.dart';
import 'package:hiwash_customer/featuers/auth/model/sign_up_model.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/widgets/components/app_snack_bar.dart';

import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';
import '../model/get_token_model.dart';
import '../model/google_sign_in_model.dart';
import '../model/send_otp_model.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  var selectedGender = "".obs;
  var showGenderError = false.obs;


  @override
  void onInit() {
    globalToken.value = LocalStorage().getToken() ?? '';

    pageController.addListener(() {
      onPageChanged(pageController.page!.round());
    });
    checkLoginStatus();
    super.onInit();
  }

  RxString globalToken = ''.obs;

  GetTokenModel? getTokenModel;
  Rx<SendOtpModel> sendOtpModel = SendOtpModel().obs;
  Rx<GoogleSignInModel> googleSignInModel = GoogleSignInModel().obs;
  SignUpModel? signUpModel;

  /// login controller
  TextEditingController loginPhoneController = TextEditingController(
    text: kDebugMode ? "90909090" : "",
  );
  TextEditingController passwordController = TextEditingController(
    text: kDebugMode ? "Abcd@123" : "",
  );

  ///signup controller
  TextEditingController nameController = TextEditingController(
    text: kDebugMode ? 'Abcd' : "",
  );
  TextEditingController emailSignUpController = TextEditingController(
    text: kDebugMode ? 'abcd@gmail.com' : "",
  );
  TextEditingController phoneController = TextEditingController(
    text: kDebugMode ? "9016824518" : "",
  );
  TextEditingController zoneController = TextEditingController(
    text: kDebugMode ? "Zone 50" : "",
  );
  TextEditingController streetController = TextEditingController(
    text: kDebugMode ? "al Matar Street" : "",
  );
  TextEditingController buildingController = TextEditingController(
    text: kDebugMode ? 'Abcd' : "",
  );
  TextEditingController unitController = TextEditingController(
    text: kDebugMode ? 'Abcd' : "",
  );

  /// forgot password controller
  TextEditingController phoneForgotController = TextEditingController();

  /// rest password controller
  TextEditingController passwordRestController = TextEditingController();
  TextEditingController cPasswordRestController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  /// Welcome screen
  final PageController pageController = PageController();

  var currentPage = 0.obs;

  var isLoading = false.obs;
  var enteredOtp = ''.obs;
  var secondsRemaining = 60.obs;
  Timer? _timer;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  final List<String> headingText = ["kEcoCleanWalletGreen", "Wash & Win!"];

  final List<String> backgroundImages = [
    Assets.imagesWelcomeBg,
    Assets.imagesWelcomMapBg,
  ];

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstant.kEMailIsRequired.tr;
    } else if (!RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(value)) {
      return StringConstant.kPLeaseEnterValid.tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstant.kPasswordIsRequired.tr;
    }
    if (value.length < 8) {
      return StringConstant.kPasswordMustBeAtLeast.tr;
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return StringConstant.kPasswordMustContainAtLeastOneUpperCaseLetter.tr;
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return StringConstant.kPasswordMustContainAtLeastOneLowerCaseLetter.tr;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return StringConstant.kPasswordMustContainAtLeastOneDigit.tr;
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return StringConstant.PasswordMustContainAtLeastOneSpecialCharacter.tr;
    }
    return null;
  }

  ///  name validation
  String? validateName(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return StringConstant.kNameIsRequired.tr;
    } else if (value.length < 3) {
      return StringConstant.kNameMustBeAtLeast.tr;
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return StringConstant.kNameMustOnlyContainAlphabetsAndSpaces.tr;
    }
    return null;
  }

  /// phone number
  String? validatePhoneNumber(String? value) {
    if (value != null && value.isNotEmpty) {
      value = value.trim();
      if (!RegExp(r'^\d{8,15}$').hasMatch(value)) {
        return StringConstant.kPleaseEnterYourPhoneNumber.tr;
      }
    }
    return null;
  }

  String? validatePhoneNumberLogin(String? value) {
    if (value != null && value.isNotEmpty) {
      value = value.trim();
      if (!RegExp(r'^\d{8,15}$').hasMatch(value)) {
        return StringConstant.kPleaseEnterYourPhoneNumber.tr;
      }
    } else {
      return StringConstant.kPhoneNumberCannotBeEmpty.tr;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return StringConstant.kConfirmPassword.tr;
    }
    return null;
  }

  void startTimer() {
    secondsRemaining.value = 60;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> checkLoginStatus() async {
    String? token = LocalStorage().getToken();
    if (token != null && token.isNotEmpty) {
      isLoggedIn.value = true;
      print("User already logged in");
    } else {
      isLoggedIn.value = false;
      print("User not logged in ");
    }
  }

  /// GET
  Future<SendOtpModel?> sendOtp(String phoneNumber) async {
    Map<String, dynamic> requestBody = {
      "mobileNumber": phoneNumber,
      "userType": "0",
    };
    isLoading.value = true;

    try {
      sendOtpModel.value = (await Repository().sendOtpRepo(requestBody))!;
      sendOtpModel.value?.data?.otp?.toString();

      if (sendOtpModel != null) {
        appSnackBar(
          title: StringConstant.kSuccess.tr,
          message:
              "${StringConstant.kTestOTP.tr} ${sendOtpModel.value.data?.otp}",
          backgroundColor: Colors.green,
        );

        return sendOtpModel.value;
      } else {
        throw Exception('Failed to generate OTP');
      }
    } catch (error) {
      print("Error in controller while sending OTP: $error");

      if (error.toString().contains('User not found (404)')) {
        Get.offAllNamed(RouteStrings.signUpScreen, arguments: phoneNumber);
      }

      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getFCMTokenIn() async {
    try {
      var token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        LocalStorage().saveFCMToken(token: token);
      } else {
        debugPrint("️FCM token is null.");
      }
    } catch (e, stackTrace) {
      debugPrint(" Error while fetching FCM token: $e");
      debugPrint("StackTrace: $stackTrace");
    }
  }

  Future<GetTokenModel?> getToken(String phoneNumber) async {
    Map<String, dynamic> requestBody = {
      "mobileNumber": phoneNumber,
      "userType": "0",
      "fcmToken": LocalStorage().getFCMToken(),
    };
    isLoading.value = true;

    try {
      final value = await Repository().getTokens(requestBody);
      if (value.data?.token != null && value.data!.token!.isNotEmpty) {
        LocalStorage tokenStorage = LocalStorage();
        await tokenStorage.saveToken(value.data!.token!);
        await tokenStorage.saveRefreshToken(value.data!.refreshToken!);
        await tokenStorage.saveUserId(value.data!.id.toString());

        isLoggedIn.value = true;
      }

      getTokenModel = value;
      return value;
    } catch (error) {
      print(" Error in controller send otp get token: $error");
      return null;
    } finally {
      isLoading.value = false;
    }
  }


  Future<GetRefreshToken?> refreshToken() async {
    var storedRefreshToken = LocalStorage().getRefreshToken();

    if (storedRefreshToken == null || storedRefreshToken.isEmpty) {
      await LocalStorage().removeToken();
      Get.offAllNamed(RouteStrings.welcomeScreen);
      return null;
    }

    final Map<String, dynamic> requestBody = {
      "refreshToken": storedRefreshToken,
    };

    try {
      var response = await Repository().refreshToken(requestBody);

      if (response.success == true &&
          response.data?.token != null &&
          response.data!.token!.isNotEmpty) {
        await LocalStorage().saveToken(response.data!.token!);
        await LocalStorage().saveRefreshToken(response.data!.refreshToken!);
        return response;
      }

      return null;
    } catch (e) {
      print("Error refreshing token: $e");
      return null;
    }
  }

  Future<SignUpModel?> signUp(
    String fullName,
    String phoneNumber,
    String email,
    String zone,
    String street,
    String building,
    String unit,
      String gender,
  ) async {
    Map<String, dynamic> requestBody = {
      "fullName": fullName,
      "email": email,
      "mobileNumber": phoneNumber,
      "zone": zone,
      "street": street,
      "building": building,
      "unit": unit,
      "userType": "0",
      "gender":gender
    };
    isLoading.value = true;

    try {
      signUpModel = await Repository().signUp(requestBody);


      return signUpModel;
    } catch (error) {
      print(" Error in controller send signUp: $error");
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  /// Google Login
  Future<GoogleSignInModel?> googleSignIn(String idToken) async {
    Map<String, dynamic> requestBody = {
      "idToken": idToken,
      "fcmToken": LocalStorage().getFCMToken(),
    };
    isLoading.value = true;

    try {
      final value = await Repository().googleSignUpRapo(requestBody);
      if (value.data?.token != null && value.data!.token!.isNotEmpty) {
        LocalStorage tokenStorage = LocalStorage();
        await tokenStorage.saveToken(value.data!.token!);
        await tokenStorage.saveRefreshToken(value.data!.refreshToken!);
        await tokenStorage.saveUserId(value.data!.id.toString());

        isLoggedIn.value = true;
      }

      googleSignInModel.value = value;
      return value;
    } catch (error) {
      print(" Error in controller google sign in : $error");

    } finally {
      isLoading.value = false;
    }
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleSignInAccount?.authentication;
      final credentialUser = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      Get.offAllNamed(RouteStrings.dashboardScreen);
      await FirebaseAuth.instance.isSignInWithEmailLink(
        credentialUser.toString(),
      );
    } on Exception catch (e) {
      print("Print google auth ${e}");
    }
  }

  Future<void> logout() async {
    await LocalStorage().removeToken();
    isLoggedIn.value = false;
    Get.offAllNamed(RouteStrings.welcomeScreen);
    // await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
