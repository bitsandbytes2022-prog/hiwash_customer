import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {



  TextEditingController emailPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

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

  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Required";
    }
    return null;
  }
}
