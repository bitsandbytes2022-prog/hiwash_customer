import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/auth/model/sign_up_model.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/styling/app_color.dart';

import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';
import '../model/get_token_model.dart';
import '../model/send_otp_model.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;

  @override
  void onInit() {
    pageController.addListener(() {
      onPageChanged(pageController.page!.round());
    });
    checkLoginStatus();
    super.onInit();
  }

  GetTokenModel? getTokenModel;
  SendOtpModel? sendOtpModel;
  SignUpModel? signUpModel;

  /// login controller
  TextEditingController loginPhoneController = TextEditingController(
    text: "9016824518",
  );
  TextEditingController passwordController = TextEditingController(
    text: "Abcd@123",
  );

  ///signup controller
  TextEditingController nameController = TextEditingController(text: 'Abcd');
  TextEditingController emailSignUpController = TextEditingController(
    text: 'abcd@gmail.com',
  );
  TextEditingController phoneController = TextEditingController(
    text: "9016824518",
  );
  TextEditingController zoneController = TextEditingController(text: "Zone 50");
  TextEditingController streetController = TextEditingController(
    text: "al Matar Street",
  );
  TextEditingController buildingController = TextEditingController(
    text: 'Abcd',
  );
  TextEditingController unitController = TextEditingController(text: 'Abcd');

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

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  final List<String> headingText = [
    "kEcoCleanWalletGreen", "Wash & Win!",

    //"kEcoCleanWalletGreen",
  ];
  final List<String> subText = [
    "kExclusiveDealsWithEvery",
    "Get your car washed weekly at 100+\nlocations with exclusive offers.\nMissed washes still deducted.",

    // "kExclusiveDealsWithEvery",
  ];

  final List<String> backgroundImages = [
    Assets.imagesWelcomeBg,
    Assets.imagesWelcomMapBg,

    // Assets.imagesWelcomMapBg,
  ];

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "E-mail is required";
    } else if (!RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
    ).hasMatch(value)) {
      return "Please Enter A Valid Email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one digit';
    }
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  ///  name validation
  String? validateName(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return "First Name Is Required";
    } else if (value.length < 3) {
      return "name Must Be AtLeast 3 Characters";
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return "Name Must Only Contain Alphabets";
    }
    return null;
  }

  /// phone number
  String? validatePhoneNumber(String? value) {
    if (value != null && value.isNotEmpty) {
      value = value.trim();
      if (!RegExp(r'^\d{8,15}$').hasMatch(value)) {
        return "Please Enter Valid Phone Number";
      }
    }
    return null;
  }

  String? validatePhoneNumberLogin(String? value) {
    if (value != null && value.isNotEmpty) {
      value = value.trim();
      if (!RegExp(r'^\d{8,15}$').hasMatch(value)) {
        return "Please Enter Valid Phone Number";
      }
    } else {
      return "Phone number cannot be empty";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }
    return null;
  }

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Required";
    }
    return null;
  }

  var isLoading = false.obs;
  var enteredOtp = ''.obs;
  var secondsRemaining = 30.obs;
  Timer? _timer;

  void startTimer() {
    secondsRemaining.value = 30;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }






  void checkLoginStatus() {
    String? token = LocalStorage().getToken();
    if (token != null && token.isNotEmpty) {
      isLoggedIn.value = true;
      print("User already logged in ");
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

    print("Calling sendOtp with $phoneNumber");
    isLoading.value = true;

    try {
      // Call the repository function to send OTP
      sendOtpModel = await Repository().sendOtpRepo(requestBody);
      print("Value received in controller sendOtp: $sendOtpModel");

      if (sendOtpModel != null) {
        Get.snackbar(
          'Success',
          "OTP: ${sendOtpModel?.data?.otp}",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
         colorText: AppColor.white
        );
        print("OTP: ${sendOtpModel?.data?.otp}");
        print("OTP Expiry Date: ${sendOtpModel?.data?.otpExpiredDate}");
        print("Mobile Number: ${sendOtpModel?.data?.mobileNumber}");
        return sendOtpModel;
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

  Future<GetTokenModel?> getToken(String phoneNumber) async {
    Map<String, dynamic> requestBody = {
      "mobileNumber": phoneNumber,
      "userType": "0",
    };
    print("Calling getToken with $phoneNumber");
    isLoading.value = true;

    try {
      final value = await Repository().getTokens(requestBody);
      print(" Value received in controller token: $value");
      if (value.data?.token != null && value.data!.token!.isNotEmpty) {
        LocalStorage tokenStorage = LocalStorage();
        await tokenStorage.saveToken(value.data!.token!);
        isLoggedIn.value = true;
      }

      getTokenModel = value;
      return value;

    } catch (error) {
      print(" Error in controller send otp: $error");
      return null;
    } finally {
      isLoading.value = false;
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
    };
    print("Calling getToken with $phoneNumber");
    isLoading.value = true;

    try {
      signUpModel = await Repository().signUp(requestBody);
      print(" Value received in controller: $signUpModel");

      return signUpModel;
    } catch (error) {
      print(" Error in controller send otp: $error");
      return null;
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> logout() async {
    await LocalStorage().removeToken();
    isLoggedIn.value = false;
    Get.offAllNamed(RouteStrings.welcomeScreen);
  }
}
