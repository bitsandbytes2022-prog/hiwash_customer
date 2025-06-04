import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart' as dio;
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/dashboard/view/second_drawer/model/faq_response_model.dart';
import 'package:hiwash_customer/featuers/profile/model/terms_and_conditions_response_model.dart';
import 'package:hiwash_customer/featuers/rewads/model/get_offers_by_id_model.dart';
import 'package:hiwash_customer/featuers/rewads/model/offer_response_model.dart';
import 'package:hiwash_customer/featuers/subscription/model/get_subscription_membership_model.dart';
import 'package:hiwash_customer/featuers/subscription/model/get_subscription_model.dart';
import 'package:hiwash_customer/featuers/dashboard/model/get_customer_data_model.dart';
import 'package:hiwash_customer/featuers/wash_status/model/wash_summry.dart';
import 'package:hiwash_customer/network_manager/utils/api_response.dart';

import '../featuers/auth/model/get_token_model.dart';
import '../featuers/auth/model/send_otp_model.dart';
import '../featuers/auth/model/sign_up_model.dart';
import '../featuers/dashboard/view/second_drawer/model/guides_response_model.dart';
import '../featuers/notification/model/notification.dart';
import '../featuers/rewads/model/get_offer_categories.dart';
import '../featuers/wash_status/model/get_location_model.dart';
import '../route/route_strings.dart';
import 'api_constant.dart';
import 'dio_helper.dart';
import 'local_storage.dart';

class Repository {
  final DioHelper dioHelper = DioHelper();
  final LocalStorage localStorage = LocalStorage();

  Future<SendOtpModel?> sendOtpRepo(Map<String, dynamic> requestBody) async {
    final dio = Dio();

    try {
      final response = await dio.post(ApiConstant.sendOtp, data: requestBody);
print("------>c${response.data}");
      if (response.statusCode == 200) {
        return SendOtpModel.fromJson(response.data);

      } else {
        throw Exception('Failed to send OTP: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final errorData = e.response?.data['error'];

        if (errorData != null) {
          int errorCode = errorData['code'];
          String errorMessage = errorData['message'];

          if (errorCode == 404 && errorMessage == "Your account not found.") {
            print("Error 404: $errorMessage");
            throw Exception('User not found (404): $errorMessage');
          } else {
            print("Error: $errorMessage");
            throw Exception('Failed to send OTP: $errorMessage');
          }
        }

        print("Unexpected error response: ${e.response?.data}");
      } else {
        print("Error sending request: ${e.message}");
      }
      throw Exception('Failed to send OTP: ${e.message}');
    } catch (e) {
      print("Error: $e");
      throw Exception('Failed to send OTP: $e');
    }
  }


  Future<SendOtpModel?> sendOtp(Object requestBody) async {
    var response = await dioHelper.post(
      url: ApiConstant.sendOtp,
      requestBody: requestBody,
    );
    print("Response from API: $response"); // Debug print
    return SendOtpModel.fromJson(response);
  }




  Future<GetTokenModel> getTokens(Object requestBody) async {
    // print("body--->: $requestBody");
    //  print("url--->: ${ApiConstant.getToken}");

    var response = await dioHelper.post(
      url: ApiConstant.getToken,
      requestBody: requestBody,
    );
    //   print("Response--->: $response");

    return GetTokenModel.fromJson(response);
  }

  Future<GetTokenModel> refreshToken(Object requestBody) async {
    // print("body--->: $requestBody");
    //  print("url--->: ${ApiConstant.getToken}");

    var response = await dioHelper.post(
      url: ApiConstant.refreshToken,
      requestBody: requestBody,
    );
    //   print("Response--->: $response");

    return GetTokenModel.fromJson(response);
  }

  Future<SignUpModel> signUp(Object requestBody) async {
    var response = await dioHelper.post(
      url: ApiConstant.signUp,
      requestBody: requestBody,
    );
    // print("Sign Response--->: $response");
    return SignUpModel.fromJson(response);
  }

  Future<GetCustomerData> getCustomerData(int id) async {
    print("url dss--->:${ApiConstant.getCustomerId(id)}");
    var response = await dioHelper.get(
      url: ApiConstant.getCustomerId(id),
      isAuthRequired: true,
    );
    print("getCustomerData response--->${response.toString()}");

    return GetCustomerData.fromJson(response);
  }

  Future<GetSubscriptionModel> getSubscription() async {
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.getSubscription,
      isAuthRequired: true,
    );
    return GetSubscriptionModel.fromJson(response);
  }

  Future<ApiResponse> getSubscriptionMembership(Object requestBody) async {
    Map<String, dynamic> response = await dioHelper.post(
      url: ApiConstant.baseUrl + ApiConstant.getSubscriptionMembership,
      isAuthRequired: true,
      requestBody: requestBody,
    );
    return ApiResponse.fromJson(response);
  }

  Future<FaqResponseModel> getFaq(int entityType) async {
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.baseUrl + ApiConstant.getFaq(entityType),
      isAuthRequired: true,
    );
    return FaqResponseModel.fromJson(response);
  }

  Future<GuidesResponseModel> getGuides(int entityType) async {
    var response = await dioHelper.get(
      url: ApiConstant.baseUrl + ApiConstant.getGuides(entityType),
      isAuthRequired: true,
    );

    return GuidesResponseModel.fromJson(response);
  }

  Future<TermsAndConditionsResponseModel> getTermsAndConditions(
    int entityType,
  ) async {
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.baseUrl + ApiConstant.getTermsAndConditions(entityType),
      isAuthRequired: true,
    );
    //  print("---->termcondition${response.toString()}");
    return TermsAndConditionsResponseModel.fromJson(response);
  }

  /*  Future<GetOfferResponseModel> getAllOffer() async {
    var response = await dioHelper.get(
      url: ApiConstant.getOffers,
      isAuthRequired: true,
    );
    return GetOfferResponseModel.fromJson(response.data);
  }*/
  Future<GetOfferResponseModel> getAllOffer() async {
    // print("url--->:${ApiConstant.getOffers}");
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.getOffers,
      isAuthRequired: true,
    );
    // print("Response--->: $response");
    return GetOfferResponseModel.fromJson(response);
  }

  Future<GetOffersByIdModel> getOfferById(int id) async {
    // print("url--->:${ApiConstant.getOffersById}");
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.getOffersById(id),
      isAuthRequired: true,
    );
    print("Response--->: $response");
    return GetOffersByIdModel.fromJson(response);
  }

  Future<ApiResponse> rating(Object requestBody) async {
    // print("Rating body--->: $requestBody");
    Map<String, dynamic> response = await dioHelper.post(
      url: ApiConstant.rating,
      requestBody: requestBody,
      isAuthRequired: true,
    );
    //  print("Rating Response--->: $response");
    return ApiResponse.fromJson(response);
  }

  Future<GetOfferCategoriesModel> getOfferCategories() async {
    // print("url--->:${ApiConstant.offerCategories}");
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.offerCategories,
      isAuthRequired: true,
    );
    // print("Response--->: $response");
    return GetOfferCategoriesModel.fromJson(response);
  }

  Future<WashSummaryModel> washSummary() async {
    // print("washSummary url--->:${ApiConstant.washSummary}");
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.washSummary,
      isAuthRequired: true,
    );
    // print("Response--->: $response");
    return WashSummaryModel.fromJson(response);
  }

/*

  Future<dynamic> uploadProfilePictureRepo(requestBody) async {
    print("Request Body Type: ${requestBody.runtimeType}");
    try {
      final response = await dioHelper.uploadFile(
        url: ApiConstant.uploadProfileImage,
        requestBody: requestBody,
        isAuthRequired: true,
      );

      print("Upload success: $response");
    } catch (e) {
      print("Upload failed: $e");
    }
  }
*/
  Future<dynamic> uploadProfilePicture(requestBody) async {
    try {
      final response = await dioHelper.post(
        url: ApiConstant.uploadProfileImage,
        requestBody: requestBody,
        isAuthRequired: true,
      );
      print("Upload success: $response");

      return response;
    } catch (e) {
      print("Upload failed: $e");
    }
  }


  Future<dynamic> uploadProfile(Object requestBody) async {
    try {
      final response = await dioHelper.put(
        url: ApiConstant.uploadProfile,
        requestBody: requestBody,
        isAuthRequired: true,
      );
      print("Save profile success: $response");
      return response;
    } catch (e) {
      print("Save profile failed: $e");
    }
  }

  Future<NotificationModel> notificationRepo() async {
    print("{Notification------>${ApiConstant.notification}}");
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.notification,
      isAuthRequired: true,
    );
    print("{Notification------>${response}}");
    return NotificationModel.fromJson(response);
  }

  Future<GetLocationModel> getLocationRepo(Object requestBody) async {
    Map<String, dynamic> response = await dioHelper.post(
      url: ApiConstant.getLocation,
      isAuthRequired: true,
      requestBody: requestBody,
    );

    return GetLocationModel.fromJson(response);
  }



  Future<dynamic> getNotificationRepo(Object requestBody) async {
    Map<String, dynamic> response = await dioHelper.post(
      url: ApiConstant.notificationUrl,
      isAuthRequired: true,
      requestBody: requestBody,
    );

    return response;
  }


}
