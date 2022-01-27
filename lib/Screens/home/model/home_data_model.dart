// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) => HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  HomeDataModel({
    this.result,
    this.message,
    this.restaurants,
    this.trending,
    this.papular,
    this.status,
  });

  bool? result;
  String? message;
  List<Restaurant>? restaurants;
  List<Papular>? trending;
  List<Papular>? papular;
  int? status;

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
        result: json["result"],
        message: json["message"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
        trending: List<Papular>.from(json["trending"].map((x) => Papular.fromJson(x))),
        papular: List<Papular>.from(json["papular"].map((x) => Papular.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "restaurants": List<dynamic>.from(restaurants!.map((x) => x.toJson())),
        "trending": List<dynamic>.from(trending!.map((x) => x.toJson())),
        "papular": List<dynamic>.from(papular!.map((x) => x.toJson())),
        "status": status,
      };
}

class Papular {
  Papular({
    this.id,
    this.userId,
    this.itemName,
    this.price,
    this.mrp,
    this.offer,
    this.status,
    this.submenuId,
    this.couponCode,
    this.avgRating,
    this.noOfRating,
    this.itemImg,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? itemName;
  int? price;
  int? mrp;
  dynamic offer;
  String? status;
  int? submenuId;
  dynamic couponCode;
  dynamic avgRating;
  int? noOfRating;
  String? itemImg;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Papular.fromJson(Map<String, dynamic> json) => Papular(
        id: json["id"],
        userId: json["user_id"],
        itemName: json["Item_name"],
        price: json["price"],
        mrp: json["mrp"],
        offer: json["offer"],
        status: json["status"],
        submenuId: json["submenu_id"],
        couponCode: json["coupon_code"],
        avgRating: json["avg_rating"],
        noOfRating: json["no_of_rating"] == null ? null : json["no_of_rating"],
        itemImg: json["item_img"] == null ? null : json["item_img"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "Item_name": itemName,
        "price": price,
        "mrp": mrp,
        "offer": offer,
        "status": status,
        "submenu_id": submenuId,
        "coupon_code": couponCode,
        "avg_rating": avgRating,
        "no_of_rating": noOfRating == null ? null : noOfRating,
        "item_img": itemImg == null ? null : itemImg,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.avgRating,
    this.noOfRating,
    this.restaurantImg,
  });
  int? id;
  String? name;
  dynamic avgRating;
  dynamic noOfRating;
  String? restaurantImg;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        avgRating: json["avg_rating"],
        noOfRating: json["no_of_rating"],
        restaurantImg: json["restaurant_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avg_rating": avgRating,
        "no_of_rating": noOfRating,
        "restaurant_img": restaurantImg,
      };
}
