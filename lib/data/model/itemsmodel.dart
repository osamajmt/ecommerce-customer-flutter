class ItemsModel {
  int? id;
  int? categoryId;
  String? name;
  String? nameAr;
  String? desc;
  String? descAr;
  int? price;
  int? count;
  int? discount;
  int? isActive;
  String? image;
  String? createdAt; 
  String? updatedAt; 
  double? discountPrice; 
  int? isFavorite;

  ItemsModel({
    this.id,
    this.categoryId,
    this.isFavorite,
    this.name,
    this.nameAr,
    this.desc,
    this.descAr,
    this.price,
    this.count,
    this.discount,
    this.isActive,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.discountPrice,
  });

  ItemsModel.fromJson(Map<String, dynamic> json) {
  
    id = _parseInt(json['id']);
    categoryId = _parseInt(json['category_id']);
    name = json['name'];
    nameAr = json['name_ar'];
    desc = json['desc'];
    descAr = json['desc_ar'];
    price = _parseInt(json['price']);
    count = _parseInt(json['count']);
    discount = _parseInt(json['discount']);
    isActive = _parseInt(json['is_active']);
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at']; 
    isFavorite = _parseInt(json['is_favorite']);
    discountPrice = _parseDouble(json['discount_price']);
  }

  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value);
    }
    if (value is double) {
      return value.toInt();
    }
    return null;
  }

  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['name'] = name;
    data['name_ar'] = nameAr;
    data['desc'] = desc;
    data['desc_ar'] = descAr;
    data['price'] = price;
    data['count'] = count;
    data['discount'] = discount;
    data['is_active'] = isActive; 
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['discount_price'] = discountPrice;
    data['is_favorite'] = isFavorite;
    return data;
  }
}

