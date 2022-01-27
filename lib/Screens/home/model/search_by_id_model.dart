// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SearchByIdModel searchByIdModelFromJson(String str) => SearchByIdModel.fromJson(json.decode(str));

String searchByIdModelToJson(SearchByIdModel data) => json.encode(data.toJson());

class SearchByIdModel {
  SearchByIdModel({
    this.result,
    this.message,
    this.data,
    this.image,
    this.items,
    this.menu,
    this.status,
  });

  bool? result;
  String? message;
  List<Datum>? data;
  List<Image>? image;
  List<Item>? items;
  List<Menu>? menu;
  int? status;

  factory SearchByIdModel.fromJson(Map<String, dynamic> json) => SearchByIdModel(
        result: json["result"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        image: List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<Datum>.from(data!.map((x) => x.toJson())),
        "image": List<Image>.from(image!.map((x) => x.toJson())),
        "items": List<Item>.from(items!.map((x) => x.toJson())),
        "menu": List<dynamic>.from(menu!.map((x) => x.toJson())),
        "status": status,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.email,
    this.restaurantMobile,
    this.isAdmin,
    this.emailVerifiedAt,
    this.restaurantOpentime,
    this.restaurantClosetime,
    this.restaurantLocation,
    this.avgRating,
    this.noOfRating,
    this.restaurantImg,
    this.createdAt,
    this.updatedAt,
  });
  int? id;
  String? name;
  String? email;
  String? restaurantMobile;
  int? isAdmin;
  dynamic emailVerifiedAt;
  DateTime? restaurantOpentime;
  DateTime? restaurantClosetime;
  String? restaurantLocation;
  dynamic avgRating;
  dynamic noOfRating;
  String? restaurantImg;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        restaurantMobile: json["restaurant_mobile"],
        isAdmin: json["is_admin"],
        emailVerifiedAt: json["email_verified_at"],
        restaurantOpentime: DateTime.parse(json["restaurant_opentime"]),
        restaurantClosetime: DateTime.parse(json["restaurant_closetime"]),
        restaurantLocation: json["restaurant_location"],
        avgRating: json["avg_rating"],
        noOfRating: json["no_of_rating"],
        restaurantImg: json["restaurant_img"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "restaurant_mobile": restaurantMobile,
        "is_admin": isAdmin,
        "email_verified_at": emailVerifiedAt,
        "restaurant_opentime": restaurantOpentime!.toIso8601String(),
        "restaurant_closetime": restaurantClosetime!.toIso8601String(),
        "restaurant_location": restaurantLocation,
        "avg_rating": avgRating,
        "no_of_rating": noOfRating,
        "restaurant_img": restaurantImg,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Image {
  Image({
    this.id,
    this.restId,
    this.bannerImg,
    this.images,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? restId;
  String? bannerImg;
  dynamic images;
  int? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        restId: json["rest_id"],
        bannerImg: json["banner_img"],
        images: json["images"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rest_id": restId,
        "banner_img": bannerImg,
        "images": images,
        "type": type,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Item {
  Item({
    this.id,
    this.itemName,
    this.itemImg,
    this.avgRating,
    this.noOfRating,
    this.price,
  });

  int? id;
  String? itemName;
  String? itemImg;
  double? avgRating;
  int? noOfRating;
  int? price;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        itemName: json["item_name"],
        itemImg: json["item_img"] == null ? null : json["item_img"],
        avgRating: json["avg_rating"],
        noOfRating: json["no_of_rating"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_name": itemName,
        "item_img": itemImg == null ? null : itemImg,
        "avg_rating": avgRating,
        "no_of_rating": noOfRating,
        "price": price,
      };
}

class Menu {
  Menu({
    this.id,
    this.userId,
    this.mName,
    this.mImage,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? mName;
  String? mImage;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        id: json["id"],
        userId: json["user_id"],
        mName: json["m_name"],
        mImage: json["m_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "m_name": mName,
        "m_image": mImage,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
