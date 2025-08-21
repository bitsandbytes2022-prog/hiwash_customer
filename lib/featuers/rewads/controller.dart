import 'dart:async';

import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/rewads/model/get_offer_categories.dart';
import 'package:hiwash_customer/featuers/rewads/model/offer_response_model.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/widgets/components/loader.dart';
import '../../generated/assets.dart';
import '../../network_manager/repository.dart';
import 'model/get_offers_by_id_model.dart';

class RewardController extends GetxController {
  final RxBool isVisible = false.obs;
  RxString selectedCategory = ''.obs;
  final RxBool isLoading = false.obs;
  final List<String> sortingList = [
    StringConstant.kAscending.tr,
    StringConstant.kDescending.tr,
  ];

  RxInt selectedSortingIndex = 0.obs;

  Rxn<GetOfferResponseModel> offerResponseModel = Rxn();
  Rxn<GetOffersByIdModel> getOffersByIdModel = Rxn();
  Rxn<GetOfferCategoriesModel> getOfferCategoriesModel = Rxn();
  RxInt selectedDropDownIndex = (1).obs;

  // In RewardController
  RxString selectedCategoryName = ''.obs;
  RxString selectedCategoryNameFilter = ''.obs;
  RxList<Offers> filteredOffers = <Offers>[].obs;

  var selectedCategoryIndex = 0.obs;

  void clearCategoryFilter() {
    selectedCategoryIndex.value = 1;
    filteredOffers.clear();
  }



  final List<String> images = [
    Assets.demoOffer1,
    Assets.demoOffer2,
    Assets.demoOffer3,
  ];

 // RxInt selectedFilterIndex = 1.obs;
  RxInt selectedFilterIndex = 1.obs;


  final List<String> offerFilterList = [

    StringConstant.kExpiringSoon.tr,
    StringConstant.kLimitedQuantity.tr,
    StringConstant.kRedeemed.tr,
    StringConstant.kFree.tr,
    StringConstant.kDiscounted.tr,
  ];
  Future<void> applyFilter(int index) async {
    try {
      isLoading.value = true;
      selectedFilterIndex.value = index;
      await getAllOffersByFilter(index);

      applySortingIfNeeded();
    } finally {
      isLoading.value = false;
    }
  }
  void applySortingIfNeeded() {
    if (selectedFilterIndex.value == 1 || selectedFilterIndex.value == 2) {
      toggleSortOrder();
    }
  }


  Future<GetOfferResponseModel?> getAllOffersByFilter(int id) async {
    try {
      offerResponseModel.value = await Repository().getAllOfferFilterRepo(id);
      return offerResponseModel.value;
    } catch (error) {
      print("Error fetching Offers Get All: $error");
    }
    return null;
  }
  RxBool isAscending = true.obs;
 // RxString sortByText = StringConstant.kSortByExpiry.tr.obs;
  RxString sortByText = StringConstant.kSortByExpiry.obs;


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
      return isAscending.value
          ? aDate.compareTo(bDate)
          : bDate.compareTo(aDate);
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
        isAscending.value
            ? StringConstant.kAscendingOrder.tr
            : StringConstant.kDescendingOrder.tr;
    applySortingToCurrentData();
  }

  void filterByCategory(int index) {
    selectedCategoryIndex.value = index;

    final selectedCategoryName =
        getOfferCategoriesModel.value?.data?[index].name?.toLowerCase().trim();

    final allOffers = offerResponseModel.value?.data?.offers ?? [];

    final matchedOffers =
        allOffers.where((offer) {
          final offerCategory = offer.categoryName?.toLowerCase().trim();
          return offerCategory == selectedCategoryName;
        }).toList();

    matchedOffers.sort((a, b) {
      final aDate = DateTime.tryParse(a.expiryDate ?? "") ?? DateTime.now();
      final bDate = DateTime.tryParse(b.expiryDate ?? "") ?? DateTime.now();
      return isAscending.value
          ? aDate.compareTo(bDate)
          : bDate.compareTo(aDate);
    });

    filteredOffers.value = matchedOffers;

    print(
      "Filtered by category: $selectedCategoryName, Sorted: ${matchedOffers.length}",
    );
  }

  String timeUntilExpiry(String? expiryDate) {
    if (expiryDate == null || expiryDate.isEmpty) {
      return StringConstant.kNoExpiry;
    }

    try {
      DateTime expiry = DateTime.parse(expiryDate);
      DateTime now = DateTime.now();
      Duration difference = expiry.difference(now);

      if (difference.isNegative) {
        return StringConstant.kExpired;
      } else if (difference.inDays > 365) {
        return "${(difference.inDays / 365).floor()} ${StringConstant.kYears.tr}";
      } else if (difference.inDays > 30) {
        return "${(difference.inDays / 30).floor()} ${StringConstant.kMonths.tr}";
      } else if (difference.inDays > 0) {
        return "${difference.inDays} ${StringConstant.kDays.tr}";
      } else if (difference.inHours > 0) {
        return "${difference.inHours} ${StringConstant.kHours.tr}";
      } else if (difference.inMinutes > 0) {
        return "${difference.inMinutes} ${StringConstant.kMinutes.tr}";
      } else {
        return "${difference.inSeconds} ${StringConstant.kSeconds.tr}";
      }
    } catch (e) {
      return StringConstant.kInvalidDate;
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
    final expiryDate =
        getOffersByIdModel.value?.offerDetailList?.first.expiryDate;
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
            countdown =
                "${remaining.inHours.toString().padLeft(2, '0')}:${(remaining.inMinutes % 60).toString().padLeft(2, '0')}:${(remaining.inSeconds % 60).toString().padLeft(2, '0')}";
            update();
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
      offerResponseModel.value = await Repository().getAllOffer();
      return offerResponseModel.value;
    } catch (error) {
      //loading.value = false;
      print("Error fetching Offers Get All: $error");
    }finally{
      loading.value = false;
    }
    return null;
  }

  Future<GetOffersByIdModel?> getOffersById(int id) async {
    try {
      showLoader();
      getOffersByIdModel.value = await Repository().getOfferById(id);

      getOffersByIdModel.value;
      hideLoader();
    } catch (error) {
      hideLoader();
      print("Error fetching Offers by Di: $error");
    }
    return null;
  }

  Future<GetOfferCategoriesModel?> getOfferCategoriesMethod() async {
    try {
      getOfferCategoriesModel.value = await Repository().getOfferCategories();

      return getOfferCategoriesModel.value;
    } catch (error) {
      print("Error fetching Offers Categories: $error");
    }
    return null;
  }

  void resetFiltersAndLoad() async {

    selectedFilterIndex.value = 1;
    sortByText.value = StringConstant.kSortByExpiry.tr;
    isAscending.value = true;
    clearCategoryFilter();
    filteredOffers.clear();

    isLoading.value = true;
    try {
      await getAllOffers();
    } finally {
      isLoading.value = false;
    }
  }
}
