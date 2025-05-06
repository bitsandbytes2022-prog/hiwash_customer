class GetLocationModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetLocationModel({this.success, this.message, this.data});

  GetLocationModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? lattitude;
  String? longitude;
  Null? address;
  Null? city;
  Null? state;
  Null? country;
  double? distanceInKm;

  Data(
      {this.id,
        this.name,
        this.lattitude,
        this.longitude,
        this.address,
        this.city,
        this.state,
        this.country,
        this.distanceInKm});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    distanceInKm = json['distanceInKm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['distanceInKm'] = this.distanceInKm;
    return data;
  }
}
