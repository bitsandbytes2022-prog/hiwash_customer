import 'package:hiwash_customer/network_manager/api_constant.dart';

class GetOfferResponseModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetOfferResponseModel({this.success, this.message, this.data});

  GetOfferResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? businessName;
  String? categoryName;
  String? title;
  String? description;
  String? offerDetails;
  String? howToRedeem;
  String? termsAndConditions;
  String? discountValue;
  String? expiryDate;
  String? image;

  Data(
      {this.id,
        this.businessName,
        this.categoryName,
        this.title,
        this.description,
        this.offerDetails,
        this.howToRedeem,
        this.termsAndConditions,
        this.discountValue,
        this.expiryDate,
        this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['businessName'];
    categoryName = json['categoryName'];
    title = json['title'];
    description = json['description'];
    offerDetails = json['offerDetails'];
    howToRedeem = json['howToRedeem'];
    termsAndConditions = json['termsAndConditions'];
    discountValue = json['discountValue'].toString();
    expiryDate = json['expiryDate'];
    image = json['image'] != null
        ? "${ApiConstant.baseImageUrl}${json['image']}"
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['businessName'] = this.businessName;
    data['categoryName'] = this.categoryName;
    data['title'] = this.title;
    data['description'] = this.description;
    data['offerDetails'] = this.offerDetails;
    data['howToRedeem'] = this.howToRedeem;
    data['termsAndConditions'] = this.termsAndConditions;
    data['discountValue'] = this.discountValue;
    data['expiryDate'] = this.expiryDate;
    data['image'] = this.image;
    return data;
  }
}
