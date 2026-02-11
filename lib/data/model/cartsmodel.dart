import 'dart:core';

class cartsModel {
  int? id;
  int? userId;
  int? itemId;
  String? name;
  String? nameAr;
  int? price;
  int? count;
  String? image;
  String? date;
  cartsModel({this.id, this.userId, this.itemId});
  cartsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['pivot']['user_id'];
    itemId = json['pivot']['item_id'];
    name = json['name'];
    nameAr = json['name_ar'];
    price = json['price'];
    count = json['count'];
    image = json['image'];
    date = json['date_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['item_id'] = itemId;
    data['name_ar'] = name;
    data['nameAr'] = nameAr;
    data['price'] = price;
    data['count'] = count;
    data['image'] = image;
    data['date_created'] = date;
    return data;
  }
}
