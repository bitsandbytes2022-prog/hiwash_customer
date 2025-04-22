class GetSubscriptionModel {
  bool? success;
  String? message;
  List<Data>? data;

  GetSubscriptionModel({this.success, this.message, this.data});

  GetSubscriptionModel.fromJson(Map<String, dynamic> json) {
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
  String? description;
  String? currency;
  int? price;
  int? duration;
  String? note;
  bool? isPremium;

  Data(
      {this.id,
        this.name,
        this.description,
        this.currency,
        this.price,
        this.duration,
        this.note,
        this.isPremium});

  Data.fromJson(Map<String, dynamic> json) {
    id = (json['id'] as num?)?.toInt();

    name = json['name'];
    description = json['description'];
    currency = json['currency'];
    price = (json['price'] as num?)?.toInt();
    duration = (json['duration'] as num?)?.toInt();
    note = json['note'];
    isPremium = json['isPremium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['currency'] = this.currency;
    data['price'] = this.price.toString();
    data['duration'] = this.duration.toString();
    data['note'] = this.note;
    data['isPremium'] = this.isPremium;
    return data;
  }
}
