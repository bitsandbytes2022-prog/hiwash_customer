class WashSummaryModel {
  bool? success;
  String? message;
  Data? data;

  WashSummaryModel({this.success, this.message, this.data});

  WashSummaryModel.fromJson(Map<String, dynamic> json) {
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
  Summary? summary;
  List<CompletedWash>? completedWash;

  Data({this.summary, this.completedWash});

  Data.fromJson(Map<String, dynamic> json) {
    summary =
    json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    if (json['completedWash'] != null) {
      completedWash = <CompletedWash>[];
      json['completedWash'].forEach((v) {
        completedWash!.add(new CompletedWash.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.completedWash != null) {
      data['completedWash'] =
          this.completedWash!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  int? totalWashes;
  String? remainingWashes;

  Summary({this.totalWashes, this.remainingWashes});

  Summary.fromJson(Map<String, dynamic> json) {
    totalWashes = json['totalWashes'];
    remainingWashes = json['remainingWashes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalWashes'] = this.totalWashes;
    data['remainingWashes'] = this.remainingWashes;
    return data;
  }
}

class CompletedWash {
  int? id;
  String? redeemedAt;
  String? locationName;
  String? address;
  String? city;
  String? state;
  String? country;
  String? latitude;
  String? longitude;
  int? rating;
  String? comment;
  String? locationImage;

  CompletedWash(
      {this.id,
        this.redeemedAt,
        this.locationName,
        this.address,
        this.city,
        this.state,
        this.country,
        this.latitude,
        this.longitude,
        this.rating,
        this.comment,
        this.locationImage});

  CompletedWash.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    redeemedAt = json['redeemedAt'];
    locationName = json['locationName'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    rating = json['rating'];
    comment = json['comment'];
    locationImage = json['locationImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['redeemedAt'] = this.redeemedAt;
    data['locationName'] = this.locationName;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['rating'] = this.rating;
    data['comment'] = this.comment;
    data['locationImage'] = this.locationImage;
    return data;
  }
}
