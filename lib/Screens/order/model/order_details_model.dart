class OrderDetailsModel {
  bool? result;
  String? message;
  List<Data>? data;
  int? status;

  OrderDetailsModel({this.result, this.message, this.data, this.status});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  int? allUsersId;
  String? cartId;
  int? itemId;
  int? userId;
  String? itemName;
  int? itemQty;
  int? itemPrice;
  int? itemMrp;
  String? image;
  String? itemOffer;
  int? totalPrice;
  String? createdAt;
  String? updatedAt;
  double? rating;

  Data(
      {this.id,
      this.allUsersId,
      this.cartId,
      this.itemId,
      this.userId,
      this.itemName,
      this.itemQty,
      this.itemPrice,
      this.image,
      this.itemMrp,
      this.itemOffer,
      this.totalPrice,
      this.createdAt,
      this.updatedAt,
      this.rating});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    allUsersId = json['all_users_id'];
    cartId = json['cart_id'];
    itemId = json['item_id'];
    userId = json['user_id'];
    itemName = json['item_name'];
    itemQty = json['item_qty'];
    itemPrice = json['item_price'];
    itemMrp = json['item_mrp'];
    image = json['image'];
    itemOffer = json['item_offer'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rating = json['item_rating'] != null ? json['item_rating'].toDouble() : json['item_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['all_users_id'] = this.allUsersId;
    data['cart_id'] = this.cartId;
    data['item_id'] = this.itemId;
    data['user_id'] = this.userId;
    data['item_name'] = this.itemName;
    data['item_qty'] = this.itemQty;
    data['item_price'] = this.itemPrice;
    data['item_mrp'] = this.itemMrp;
    data['image'] = this.image;
    data['item_offer'] = this.itemOffer;
    data['total_price'] = this.totalPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['item_rating'] = this.rating;
    return data;
  }
}
