import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/rewads/model/offer_response_model.dart';

import '../../network_manager/repository.dart';

class RewardController extends GetxController{



  GetOfferResponseModel? offerResponseModel;

  Future<GetOfferResponseModel?>getAllOffers()async{
    try {
      offerResponseModel = await Repository().getAllOffer();
      return offerResponseModel;
    } catch (error) {
      print("Error fetching Guides: $error");
      return null;
    }
  }

}