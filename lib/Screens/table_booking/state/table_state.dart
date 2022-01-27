import 'package:blue_witcher/Screens/main_page/main_page.dart';
import 'package:blue_witcher/Screens/table_booking/model/drop_list_model.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TableState with ChangeNotifier {
  List<OptionItem> _listOptionItems = [OptionItem(id: null, title: "Table no.", subtitle: "Capcity")];
  bool _loadingCoupon = false;
  bool _loading = false;
  bool _couponVaild = false;
  int _offerPrice = 0;
  List<OptionItem> get listOptionItems => _listOptionItems;
  bool get loadingCoupon => _loadingCoupon;
  bool get loading => _loading;
  bool get couponVaild => _couponVaild;
  int get offerPrice => _offerPrice;

  void getData(resId) async {
    await ApiProvider.getTables(resId).then((response) {
      _listOptionItems = new DropListModel.fromJson(response).listOptionItems;
      notifyListeners();
    });
  }

  void applyCoupon(coupon) async {
    _loadingCoupon = true;
    notifyListeners();
    await ApiProvider.applyCoupon(coupon).then((response) {
      if (response['result'] != null && response['result']) {
        _offerPrice = response["data"]["offerPrice"];
        _couponVaild = true;
        notifyListeners();
      } else if (response['result'] != null && !response['result']) {
        _offerPrice = 0;
        Fluttertoast.showToast(
            msg: response['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        Fluttertoast.showToast(
            msg: "We have some Internal Issues",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    });
    _loadingCoupon = false;
    notifyListeners();
  }

  void bookTable(context, resid, tableid, offer) {
    Map<String, dynamic> data = {};
    data["restid"] = resid;
    data["item_ids"] = [tableid];
    if (offer != null) {
      data["coupon_offer"] = offer;
    }
    ApiProvider.tableBooking(data).then((response) {
      if (response["result"] != null && response["result"]) {
        updateBooking(response["data"]["cart_id"], context);
      } else if (response["result"] != null && !response["result"]) {
        Fluttertoast.showToast(
            msg: response['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        Fluttertoast.showToast(
            msg: "We have some Internal Issues",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    });
  }

  void updateBooking(cartId, context) {
    Map<String, String> data = {};
    data["order_id"] = cartId;
    data["status"] = "success";

    ApiProvider.updateBookingPayment(data).then((response) {
      if (response["result"] != null && response["result"]) {
        Fluttertoast.showToast(
            msg: response['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
        _offerPrice = 0;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => MainPage(
                      index: 3,
                    )),
            (route) => false);
      } else if (response["result"] != null && !response["result"]) {
        Fluttertoast.showToast(
            msg: response['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      } else {
        Fluttertoast.showToast(
            msg: "We have some Internal Issues",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    });
  }

  void changeCouponVaild() {
    _couponVaild = false;
    notifyListeners();
  }
}
