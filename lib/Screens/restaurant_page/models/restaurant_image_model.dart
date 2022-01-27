import 'dart:convert';

List<RestaurantImageModel> restaurantImageModelFromJson(String str) =>
    List<RestaurantImageModel>.from(json.decode(str).map((x) => RestaurantImageModel.fromJson(x)));

String restaurantImageModelToJson(List<RestaurantImageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RestaurantImageModel {
  RestaurantImageModel({
    this.id,
    this.restId,
    this.images,
  });

  int? id;
  int? restId;
  String? images;

  factory RestaurantImageModel.fromJson(Map<String, dynamic> json) => RestaurantImageModel(
        id: json["id"],
        restId: json["rest_id"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rest_id": restId,
        "images": images,
      };
}
