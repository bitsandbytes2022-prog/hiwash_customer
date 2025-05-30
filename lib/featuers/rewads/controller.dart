import 'dart:async';

import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/rewads/model/get_offer_categories.dart';
import 'package:hiwash_customer/featuers/rewads/model/offer_response_model.dart';
import 'package:hiwash_customer/widgets/components/loader.dart';
import '../../generated/assets.dart';
import '../../network_manager/repository.dart';
import 'model/get_offers_by_id_model.dart';

class RewardController extends GetxController {
  final RxBool isVisible = false.obs;
  RxString selectedCategory = ''.obs;

  Rxn<GetOfferResponseModel> offerResponseModel = Rxn();
  Rxn<GetOffersByIdModel> getOffersByIdModel = Rxn();
  Rxn<GetOfferCategoriesModel> getOfferCategoriesModel = Rxn();
  RxInt selectedDropDownIndex = (-1).obs;
  // In RewardController
  RxString selectedCategoryName = ''.obs;
  RxString selectedCategoryNameFilter = ''.obs;
  RxList<Offers> filteredOffers = <Offers>[].obs;


  var selectedCategoryIndex = 0.obs;


  void clearCategoryFilter() {
    selectedCategoryIndex.value = 0;
  filteredOffers.clear();
  }


  final List<String> images = [
    Assets.imagesDemoProfile,
    Assets.imagesDemoProfile,
    Assets.imagesDemoProfile,
  ];

  RxBool isAscending = true.obs;
  RxString sortByText = "Sort by Expiry".obs;
  void applySortingToCurrentData() {
    List<Offers> data;

    if (filteredOffers.isNotEmpty) {
      data = [...filteredOffers];
    } else {
      data = [...(offerResponseModel.value?.data?.offers ?? [])];
    }

    data.sort((a, b) {
      final aDate = DateTime.tryParse(a.expiryDate ?? "") ?? DateTime.now();
      final bDate = DateTime.tryParse(b.expiryDate ?? "") ?? DateTime.now();
      return isAscending.value ? aDate.compareTo(bDate) : bDate.compareTo(aDate);
    });

    if (filteredOffers.isNotEmpty) {
      filteredOffers.value = data;
    } else {
      offerResponseModel.update((val) {
        val?.data?.offers = data;
      });
    }

    print("Applied sorting - Ascending: ${isAscending.value}");
  }

  void toggleSortOrder() {
    isAscending.value = !isAscending.value;
    sortByText.value =
    isAscending.value ? 'Ascending Order' : 'Descending Order';
    applySortingToCurrentData();
  }

  void filterByCategory(int index) {
    selectedCategoryIndex.value = index;

    final selectedCategoryName =
    getOfferCategoriesModel.value?.data?[index].name?.toLowerCase().trim();

    final allOffers = offerResponseModel.value?.data?.offers ?? [];

    final matchedOffers = allOffers.where((offer) {
      final offerCategory = offer.categoryName?.toLowerCase().trim();
      return offerCategory == selectedCategoryName;
    }).toList();

    matchedOffers.sort((a, b) {
      final aDate = DateTime.tryParse(a.expiryDate ?? "") ?? DateTime.now();
      final bDate = DateTime.tryParse(b.expiryDate ?? "") ?? DateTime.now();
      return isAscending.value ? aDate.compareTo(bDate) : bDate.compareTo(aDate);
    });

    filteredOffers.value = matchedOffers;

    print("Filtered by category: $selectedCategoryName, Sorted: ${matchedOffers.length}");
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

  bool isOfferExpired(String? expiryDateStr) {
    if (expiryDateStr == null || expiryDateStr.isEmpty) return false;
    try {
      final expiryDate = DateTime.parse(expiryDateStr);
      return DateTime.now().isAfter(expiryDate);
    } catch (e) {
      return false;
    }
  }


  Timer? _timer;
  String countdown = "";

  void startCountdown() {
    final expiryDate = getOffersByIdModel.value?.offerDetailList?.first.expiryDate;
    if (expiryDate != null) {
      final expiryDateTime = DateTime.parse(expiryDate);
      final now = DateTime.now();
      final difference = expiryDateTime.difference(now);

      if (difference.inHours < 24) {
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          final remaining = expiryDateTime.difference(DateTime.now());
          if (remaining.isNegative) {
            _timer?.cancel();

              countdown = "Expired";
              update();
          } else {

              countdown = "${remaining.inHours.toString().padLeft(2, '0')}:${(remaining.inMinutes % 60).toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}";
        update()
              ;
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  RxBool loading = false.obs;

  Future<GetOfferResponseModel?> getAllOffers() async {
    try {
      loading.value = true;
      update();
      offerResponseModel.value = await Repository().getAllOffer();
      return offerResponseModel.value;
    } catch (error) {
      loading.value = false;
      update();
      print("Error fetching Offers Get All: $error");
    }
    return null;
  }

  Future<GetOffersByIdModel?> getOffersById(int id) async {
    try {
      //loading.value = true;
showLoader();
      getOffersByIdModel.value = await Repository().getOfferById(id);

       getOffersByIdModel.value;
       hideLoader();
       //update();
    } catch (error) {
hideLoader();
      print("Error fetching Offers by Di: $error");
    }
    return null;
  }

  Future<GetOfferCategoriesModel?> getOfferCategoriesMethod() async {
    try {

      getOfferCategoriesModel.value = await Repository().getOfferCategories();

      print(" ppppp----->${getOfferCategoriesModel.toJson().toString()}");
      return getOfferCategoriesModel.value;
    } catch (error) {

      print("Error fetching Offers Categories: $error");
    }
    return null;
  }


}
