import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/rewads/model/get_offer_categories.dart';
import 'package:hiwash_customer/featuers/rewads/model/offer_response_model.dart';
import '../../generated/assets.dart';
import '../../network_manager/repository.dart';
import 'model/get_offers_by_id_model.dart';

class RewardController extends GetxController {
  final RxBool isVisible = false.obs;

  Rxn<GetOfferResponseModel>offerResponseModel=Rxn();
  Rxn<GetOffersByIdModel>getOffersByIdModel=Rxn();
  Rxn<GetOfferCategoriesModel>getOfferCategoriesModel=Rxn();
  RxInt selectedDropDownIndex = (-1).obs;

  bool loading = false;
  Future<GetOfferResponseModel?> getAllOffers() async {
    try {
      loading = true;
      update();
      offerResponseModel.value = await Repository().getAllOffer();
      return offerResponseModel.value;
    } catch (error) {
      loading = false;
      update();
      print("Error fetching Offers Get All: $error");
    }
    return null;
  }

  Future<GetOffersByIdModel?> getOffersById(int id) async {

    try {
       getOffersByIdModel.value = await Repository().getOfferById(id);
       update();
     return  getOffersByIdModel.value;

    } catch (error) {
      print("Error fetching Offers by Di: $error");
    }
    return null;
  }



  Future<GetOfferCategoriesModel?> getOfferCategoriesMethod() async {
    try {
      loading = true;
      update();
      getOfferCategoriesModel.value = await Repository().getOfferCategories();
      return  getOfferCategoriesModel.value;
    } catch (error) {
      loading = false;
      update();
      print("Error fetching Offers Categories: $error");
    }
    return null;
  }
  final List<String> images = [
    Assets.demoOffer1,
    Assets.demoOffer2,
    Assets.demoOffer3,
  ];

  RxBool isAscending = true.obs;

  void toggleSortOrder() {
    isAscending.value = !isAscending.value;

    final offers = offerResponseModel.value?.data?.offers ?? [];
    offers.sort((a, b) {
      final aDate = DateTime.tryParse(a.expiryDate ?? "") ?? DateTime.now();
      final bDate = DateTime.tryParse(b.expiryDate ?? "") ?? DateTime.now();
      return isAscending.value
          ? aDate.compareTo(bDate)
          : bDate.compareTo(aDate);
    });

    offerResponseModel.update((val) {
      val?.data?.offers = offers;
    });
  }
  String timeUntilExpiry(String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) {
      return "No Expiry";
    }

    try {
      DateTime expiry = DateTime.parse(expiryDate);
      DateTime now = DateTime.now();
      Duration difference = expiry.difference(now);

      if (difference.isNegative) {
        return "Expired";
      } else if (difference.inDays > 365) {
        return "${(difference.inDays / 365).floor()} years";
      } else if (difference.inDays > 30) {
        return "${(difference.inDays / 30).floor()} months";
      } else if (difference.inDays > 0) {
        return "${difference.inDays} days";
      } else if (difference.inHours > 0) {
        return "${difference.inHours} hours";
      } else if (difference.inMinutes > 0) {
        return "${difference.inMinutes} minutes";
      } else {
        return "${difference.inSeconds} seconds";
      }
    } catch (e) {
      return "Invalid date";
    }
  }

}