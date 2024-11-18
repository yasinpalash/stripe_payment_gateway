class CardModel {
  bool? success;
  String? message;
  List<Data>? data;

  CardModel({this.success, this.message, this.data});

  CardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }


}

class Data {
  String? id;
  String? object;
  String? brand;
  String? displayBrand;
  String? last4;
  int? created;
  String? customerId;

  Data(
      {this.id,
        this.object,
        this.brand,
        this.displayBrand,
        this.last4,
        this.created,
        this.customerId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    brand = json['brand'];
    displayBrand = json['display_brand'];
    last4 = json['last4'];
    created = json['created'];
    customerId = json['customerId'];
  }
}
