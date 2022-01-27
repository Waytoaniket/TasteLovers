class BookingDetailsModel {
  bool? result;
  String? message;
  List<Data>? data;
  int? status;

  BookingDetailsModel({this.result, this.message, this.data, this.status});

  BookingDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? usersId;
  String? cartId;
  int? tableNo;
  int? tableId;
  int? tableCapacity;
  int? tablePrice;
  int? tableOffer;
  int? totalPrice;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.allUsersId,
      this.cartId,
      this.usersId,
      this.tableId,
      this.tableNo,
      this.tableCapacity,
      this.tablePrice,
      this.tableOffer,
      this.totalPrice,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    allUsersId = json['all_users_id'];
    usersId = json['user_id'];
    cartId = json['cart_id'];
    tableNo = json['table_no'];
    tableId = json['table_id'];
    tableCapacity = json['table_capacity'];
    tablePrice = json['table_price'];
    tableOffer = json['table_offer'];
    totalPrice = json['total_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['all_users_id'] = this.allUsersId;
    data['user_id'] = this.usersId;
    data['cart_id'] = this.cartId;
    data['table_no'] = this.tableNo;
    data['table_id'] = this.tableId;
    data['table_capacity'] = this.tableCapacity;
    data['table_price'] = this.tablePrice;
    data['table_offer'] = this.tableOffer;
    data['total_price'] = this.totalPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
