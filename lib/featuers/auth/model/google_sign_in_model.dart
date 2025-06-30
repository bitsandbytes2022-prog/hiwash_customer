class GoogleSignInModel {
  bool? success;
  String? message;
  Data? data;

  GoogleSignInModel({this.success, this.message, this.data});

  GoogleSignInModel.fromJson(Map<String, dynamic> json) {
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
  String? refreshToken;

  Data(
      {this.id,
        this.fullName,
        this.email,
        this.mobileNumber,
        this.token,
        this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName']!=null?json['fullName']:"";
    email = json['email'];
    mobileNumber = json['mobileNumber']!=null?json['mobileNumber']:"";
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['mobileNumber'] = this.mobileNumber;
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
