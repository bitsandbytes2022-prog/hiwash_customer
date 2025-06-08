class GetRefreshToken {
  bool? success;
  String? message;
  Data? data;

  GetRefreshToken({this.success, this.message, this.data});

  GetRefreshToken.fromJson(Map<String, dynamic> json) {
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
  int? userType;
  String? token;
  String? refreshToken;

  Data({this.id, this.userType, this.token, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['userType'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userType'] = this.userType;
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}
