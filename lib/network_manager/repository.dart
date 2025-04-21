import 'package:hiwash_customer/featuers/dashboard/view/second_drawer/model/faq_response_model.dart';
import 'package:hiwash_customer/featuers/profile/model/terms_and_conditions_response_model.dart';
import 'package:hiwash_customer/featuers/rewads/model/offer_response_model.dart';
import 'package:hiwash_customer/featuers/subscription/model/get_subscription_membership_model.dart';
import 'package:hiwash_customer/featuers/subscription/model/get_subscription_model.dart';
import 'package:hiwash_customer/featuers/wash_status/model/get_customer_data_model.dart';

import '../featuers/auth/model/get_token_model.dart';
import '../featuers/dashboard/view/second_drawer/model/guides_response_model.dart';
import 'api_constant.dart';
import 'dio_helper.dart';
import 'local_storage.dart';

class Repository {
   final DioHelper dioHelper = DioHelper();
  final LocalStorage localStorage = LocalStorage();

  Future<GetTokenModel> getTokens(Object requestBody) async {
    print("body--->: $requestBody");
    print("url--->: ${ApiConstant.getToken}");

var response = await dioHelper.post(
      url: ApiConstant.getToken,
      requestBody: requestBody,
    );
    print("Response--->: $response");
    return GetTokenModel.fromJson(response);
  }

  /*    /// GET TOKEN
    Future<GetTokenModel?> getToken(String phoneNumber) async {
      try {
        var requestBody = {"mobileNumber": phoneNumber};

        var response = await dioHelper.post(
          url: ApiConstant.baseUrl + ApiConstant.getToken,
          requestBody: requestBody,
          isAuthRequired: true,
        );

        if (response != null && response['success'] == true && response['data'] != null) {
          GetTokenModel model = GetTokenModel.fromJson(response);
          await localStorage.saveToken(model.data!.token!);
          print("Token:----${model.data?.token}");
          return model;
        } else {
          String errorMessage = response['error']['message'] ?? "An unknown error occurred.";
          print("Error: $errorMessage");
          return null;
        }
      } catch (e) {
        print("Exception caught: $e");
        return null;
      }
    }*/

  Future<GetCustomerData> getCustomerData(int id) async {
    var response = await dioHelper.get(
      url:ApiConstant.getCustomerId(id),
      isAuthRequired: true,
    );
    return GetCustomerData.fromJson(response.data);
  }

  Future<GetSubscriptionModel> getSubscription() async {
    var response = await dioHelper.get(
      url:  ApiConstant.getSubscription,
      isAuthRequired: true,
    );
    return GetSubscriptionModel.fromJson(response.data);
  }

  Future<GetSubscriptionMembershipModel> getSubscriptionMembership(
      Object requestBody,
      ) async {
    Map<String, dynamic> response = await dioHelper.post(
      url: ApiConstant.baseUrl + ApiConstant.getSubscriptionMembership,
      isAuthRequired: true,
      requestBody: requestBody,
    );
    return GetSubscriptionMembershipModel.fromJson(response);
  }

  Future<FaqResponseModel> getFaq(int entityType) async {
    var response = await dioHelper.get(
      url: ApiConstant.baseUrl + ApiConstant.getFaq(entityType),
      isAuthRequired: true,
    );
    return FaqResponseModel.fromJson(response.data);
  }

  Future<GuidesResponseModel> getGuides(int entityType) async {
    var response = await dioHelper.get(
      url: ApiConstant.baseUrl + ApiConstant.getGuides(entityType),
      isAuthRequired: true,
    );
    return GuidesResponseModel.fromJson(response.data);
  }

  Future<TermsAndConditionsResponseModel> getTermsAndConditions(
      int entityType,
      ) async {
    var response = await dioHelper.get(
      url: ApiConstant.baseUrl + ApiConstant.getTermsAndConditions(entityType),
      isAuthRequired: true,
    );
    return TermsAndConditionsResponseModel.fromJson(response.data);
  }

  Future<GetOfferResponseModel> getAllOffer() async {
    var response = await dioHelper.get(
      url: ApiConstant.getOffers,
      isAuthRequired: true,
    );
    return GetOfferResponseModel.fromJson(response.data);
  }
}
