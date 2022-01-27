import 'package:blue_witcher/Screens/confirm_order/models/place_order_model.dart';
import 'package:blue_witcher/Screens/main_page/main_page.dart';
import 'package:blue_witcher/Screens/order/order_page.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/orderstate.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class ConfirmOrder extends StatefulWidget {
  ConfirmOrder({Key? key}) : super(key: key);

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  TextEditingController couponCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Confirm Order", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.white70,
      body: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.all(5.w),
            child: TextField(
              controller: couponCodeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Coupon Code (Optional)',
              ),
            ),
          ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              FlatButton(
                minWidth: 40.w,
                color: Color(0xFFff4c40),
                onPressed: () {
                  placeOrder();
                },
                child: Text(
                  "Skip",
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
              ),
              Spacer(),
              FlatButton(
                padding: EdgeInsets.fromLTRB(3.0, 0.0, 10.0, 0.0),
                minWidth: 40.w,
                color: Color.fromRGBO(97, 125, 45, 1),
                onPressed: () async {
                  if (await applyCoupon()) placeOrder();
                },
                child: Text(
                  "Apply",
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }

  void placeOrder() async {
    EasyLoading.show(status: 'Placing your Order...', dismissOnTap: false);

    OrderState _orderState = context.read<OrderState>();
    var _placeOrderResult = await ApiProvider.placeOrder(
        _orderState.getTotalAmount,
        (_orderState.getTotalAmount * (_orderState.discount ?? 0)) ~/ 100,
        _orderState.getTableNo!.id!,
        Provider.of<RestaurantState>(context, listen: false).dataResto!.first.id!,
        _orderState.getOrderIds);
    PlaceOrderModel _placeOrderModel = PlaceOrderModel.fromJson(_placeOrderResult);
    if (_placeOrderModel.result == true) {
      var resp = await ApiProvider.confirmPendingOrder(orderId: _placeOrderModel.data!.cartId!);
      print(resp);
      EasyLoading.dismiss();
      _orderState.clear();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) {
        return MainPage(index: 0);
      }), (route) => false);
    } else {
      Fluttertoast.showToast(msg: _placeOrderModel.message!);
      return;
    }
  }

  Future<bool> applyCoupon() async {
    if (couponCodeController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please Enter a valid Coupon Code !!!");
      return false;
    }

    EasyLoading.show(status: 'Applying Coupon', dismissOnTap: false);
    var result = await ApiProvider.applyCoupon(couponCodeController.text);
    EasyLoading.dismiss();
    if (result["result"]) {
      Fluttertoast.showToast(msg: "Successfully Applied your Coupon Code!");
      context.read<OrderState>().discount = int.parse(result["data"][0]["offerPrice"].toString());
      return true;
    } else {
      Fluttertoast.showToast(msg: "Invalid Coupon Code!");
    }
    return false;
  }
}
