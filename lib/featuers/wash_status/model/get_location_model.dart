class GetLocationModel {
  bool? success;
  String? message;
  List<LocationData>? locationData;

  GetLocationModel({this.success, this.message, this.locationData});

  GetLocationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      locationData = <LocationData>[];
      json['data'].forEach((v) {
        locationData!.add(new LocationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.locationData != null) {
      data['data'] = this.locationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationData {
  int? id;
  String? name;
  String? lattitude;
  String? longitude;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic country;
  dynamic distanceInKm;

  LocationData(
      {this.id,
        this.name,
        this.lattitude,
        this.longitude,
        this.address,
        this.city,
        this.state,
        this.country,
        this.distanceInKm});

  LocationData.fromJson(Map<String, dynamic> json) {
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
