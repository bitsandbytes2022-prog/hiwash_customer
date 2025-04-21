class GetCustomerData {
  bool? success;
  String? message;
  List<Data>? data;

  GetCustomerData({this.success, this.message, this.data});

  GetCustomerData.fromJson(Map<String, dynamic> json) {
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
  String? fullName;
  String? email;
  String? mobileNumber;
  int? subscriptionId;
  String? startDate;
  String? endDate;
  String? subscriptionName;
  int? price;
  String? currency;
  int? duration;

  Data(
      {this.id,
        this.fullName,
        this.email,
        this.mobileNumber,
        this.subscriptionId,
        this.startDate,
        this.endDate,
        this.subscriptionName,
        this.price,
        this.currency,
        this.duration});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    subscriptionId = json['subscriptionId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    subscriptionName = json['subscriptionName'];
    price = json['price'];
    currency = json['currency'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['subscriptionId'] = this.subscriptionId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['subscriptionName'] = this.subscriptionName;
    data['price'] = this.price;
    data['currency'] = this.currency;
    data['duration'] = this.duration;
    return data;
  }
}
