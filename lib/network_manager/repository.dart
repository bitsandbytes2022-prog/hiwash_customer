import 'package:hiwash_customer/featuers/dashboard/view/second_drawer/model/faq_response_model.dart';
import 'package:hiwash_customer/featuers/profile/model/terms_and_conditions_response_model.dart';
import 'package:hiwash_customer/featuers/rewads/model/get_offers_by_id_model.dart';
import 'package:hiwash_customer/featuers/rewads/model/offer_response_model.dart';
import 'package:hiwash_customer/featuers/subscription/model/get_subscription_membership_model.dart';
import 'package:hiwash_customer/featuers/subscription/model/get_subscription_model.dart';
import 'package:hiwash_customer/featuers/wash_status/model/get_customer_data_model.dart';
import 'package:hiwash_customer/network_manager/utils/api_response.dart';

import '../featuers/auth/model/get_token_model.dart';
import '../featuers/dashboard/view/second_drawer/model/guides_response_model.dart';
import '../featuers/rewads/model/get_offer_categories.dart';
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
  Future<GetTokenModel> signUp(Object requestBody) async {

    var response = await dioHelper.post(
      url: ApiConstant.signUp,
      requestBody: requestBody,
    );
    print("Sign Response--->: $response");
    return GetTokenModel.fromJson(response);
  }


  Future<GetCustomerData> getCustomerData(int id) async {
    var response = await dioHelper.get(
      url: ApiConstant.getCustomerId(id),
      isAuthRequired: true,
    );
    return GetCustomerData.fromJson(response.data);
  }

  Future<GetSubscriptionModel> getSubscription() async {
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.getSubscription,
      isAuthRequired: true,
    );
    return GetSubscriptionModel.fromJson(response);
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
    print("---->termcondition${response.toString()}");
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
    print("url--->:${ApiConstant.getOffers}");
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.getOffers,
      isAuthRequired: true,
    );
    print("Response--->: $response");
    return GetOfferResponseModel.fromJson(response);
  }

  Future<GetOffersByIdModel> getOfferById(int id) async {
    print("url--->:${ApiConstant.getOffersById}");
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.getOffersById(id),
      isAuthRequired: true,
    );
    print("Response--->: $response");
    return GetOffersByIdModel.fromJson(response);
  }

  Future<ApiResponse> rating(Object requestBody) async {
    print("Rating body--->: $requestBody");
    Map<String, dynamic> response = await dioHelper.post(
      url: ApiConstant.rating,
      requestBody: requestBody,
      isAuthRequired: true,
    );
    print("Rating Response--->: $response");
    return ApiResponse.fromJson(response);
  }

  Future<GetOfferCategoriesModel> getOfferCategories() async {
    print("url--->:${ApiConstant.offerCategories}");
    Map<String, dynamic> response = await dioHelper.get(
      url: ApiConstant.getOffers,
      isAuthRequired: true,
    );
    print("Response--->: $response");
    return GetOfferCategoriesModel.fromJson(response);
  }
}
