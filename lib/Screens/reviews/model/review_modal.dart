class ReviewModel {
  bool? result;
  List<ReviewData>? data;
  String? message;

  ReviewModel({this.result, this.data, this.message});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <ReviewData>[];
      json['data'].forEach((v) {
        data!.add(new ReviewData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class ReviewData {
  int? id;
  int? restaurantId;
  int? allUserId;
  String? commentText;
  String? images;
  double? rating;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? email;
  String? mobNumber;
  String? city;
  String? image;
  String? password;
  int? otp;
  int? status;
  List<Replies> replies = [];

  ReviewData(
      {this.id,
      this.restaurantId,
      this.allUserId,
      this.commentText,
      this.images,
      this.rating,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.email,
      this.mobNumber,
      this.city,
      this.image,
      this.password,
      this.otp,
      this.status,
      required this.replies});

  ReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    allUserId = json['all_user_id'];
    commentText = json['comment_text'];
    images = json['images'];
    rating = json['rating'] != null ? json['rating'].toDouble() : json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    email = json['email'];
    mobNumber = json['mob_number'];
    city = json['city'];
    image = json['image'];
    password = json['password'];
    otp = json['otp'];
    status = json['status'];
    if (json['replies'] != null) {
      replies = <Replies>[];
      json['replies'].forEach((v) {
        replies.add(new Replies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['restaurant_id'] = this.restaurantId;
    data['all_user_id'] = this.allUserId;
    data['comment_text'] = this.commentText;
    data['images'] = this.images;
    data['rating'] = this.rating;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['email'] = this.email;
    data['mob_number'] = this.mobNumber;
    data['city'] = this.city;
    data['image'] = this.image;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['status'] = this.status;
    if (this.replies.isEmpty) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Replies {
  int? id;
  int? commentId;
  String? commentText;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Replies({this.id, this.commentId, this.commentText, this.userId, this.createdAt, this.updatedAt});

  Replies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentId = (json['comment_id'] is int) ? json['comment_id'] : int.parse(json['comment_id']);
    commentText = json['comment_text'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment_id'] = this.commentId;
    data['comment_text'] = this.commentText;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
