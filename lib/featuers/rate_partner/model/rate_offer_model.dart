class RateOfferModel {
  bool? success;
  String? message;

  RateOfferModel({this.success, this.message });

  RateOfferModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

  }


}

