class BookingModel {
  bool? result;
  String? message;
  List<BookingData>? data = [];
  int? status;

  BookingModel({this.result, this.message, this.data, this.status});

  BookingModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BookingData>[];
      json['data'].forEach((v) {
        data!.add(new BookingData.fromJson(v));
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

class BookingData {
  int? id;
  int? userId;
  int? allUsersId;
  String? cartId;
  int? totalPrice;
  String? tables;
  String? paymentStatus;
  int? status;
  int? offer;
  String? createdAt;
  String? updatedAt;

  BookingData(
      {this.id,
      this.userId,
      this.allUsersId,
      this.cartId,
      this.totalPrice,
      this.tables,
      this.paymentStatus,
      this.status,
      this.offer,
      this.createdAt,
      this.updatedAt});

  BookingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    allUsersId = json['all_users_id'];
    cartId = json['cart_id'];
    totalPrice = json['total_price'];
    tables = json['tables'].toString();
    paymentStatus = json['payment_status'];
    status = json['status'];
    offer = json['offer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['all_users_id'] = this.allUsersId;
    data['cart_id'] = this.cartId;
    data['total_price'] = this.totalPrice;
    data['tables'] = this.tables;
    data['payment_status'] = this.paymentStatus;
    data['status'] = this.status;
    data['offer'] = this.offer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
