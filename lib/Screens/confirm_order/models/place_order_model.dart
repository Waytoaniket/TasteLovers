class PlaceOrderModel {
  bool? result;
  String? message;
  Data? data;
  int? status;

  PlaceOrderModel({this.result, this.message, this.data, this.status});

  PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  int? allUsersId;
  String? cartId;
  int? totalPrice;
  int? totalMrp;
  int? tableNo;
  int? items;
  String? paymentStatus;
  int? status;
  int? offer;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.allUsersId,
      this.cartId,
      this.totalPrice,
      this.totalMrp,
      this.tableNo,
      this.items,
      this.paymentStatus,
      this.status,
      this.offer,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    allUsersId = json['all_users_id'];
    cartId = json['cart_id'];
    totalPrice = json['total_price'];
    totalMrp = json['total_mrp'];
    tableNo = json['table_no'];
    items = json['items'];
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
    data['total_mrp'] = this.totalMrp;
    data['table_no'] = this.tableNo;
    data['items'] = this.items;
    data['payment_status'] = this.paymentStatus;
    data['status'] = this.status;
    data['offer'] = this.offer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
