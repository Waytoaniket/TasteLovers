class AllOffers {
  bool? result;
  String? message;
  List<OfferData>? data;
  int? status;

  AllOffers({this.result, this.message, this.data, this.status});

  AllOffers.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['data'] != null) {
      data = <OfferData>[];
      json['data'].forEach((v) {
        data!.add(new OfferData.fromJson(v));
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

class OfferData {
  int? offerId;
  int? restaurantId;
  String? coupon;
  int? offerPrice;
  String? restaurantName;
  String? itemName;
  int? itemId;
  String? itemImg;

  OfferData(
      {this.offerId,
      this.restaurantId,
      this.coupon,
      this.offerPrice,
      this.restaurantName,
      this.itemName,
      this.itemId,
      this.itemImg});

  OfferData.fromJson(Map<String, dynamic> json) {
    offerId = json['offer_id'];
    restaurantId = json['restaurant_id'];
    coupon = json['coupon'];
    offerPrice = json['offerPrice'];
    restaurantName = json['restaurant_name'];
    itemName = json['item_name'];
    itemId = json['item_id'];
    itemImg = json['item_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offer_id'] = this.offerId;
    data['restaurant_id'] = this.restaurantId;
    data['coupon'] = this.coupon;
    data['offerPrice'] = this.offerPrice;
    data['restaurant_name'] = this.restaurantName;
    data['item_name'] = this.itemName;
    data['item_id'] = this.itemId;
    data['item_img'] = this.itemImg;
    return data;
  }
}
