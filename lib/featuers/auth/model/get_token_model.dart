class GetTokenModel {
  bool? success;
  String? message;
  Data? data;

  GetTokenModel({this.success, this.message, this.data});

  GetTokenModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? fullName;
  String? email;
  String? mobileNumber;
  String? token;

  Data({this.id, this.fullName, this.email, this.mobileNumber, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    mobileNumber = json['mobileNumber'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber.toString();
    data['token'] = this.token;
    return data;
  }
}
