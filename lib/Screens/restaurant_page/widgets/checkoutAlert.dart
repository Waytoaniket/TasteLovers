import 'package:blue_witcher/Screens/restaurant_page/models/table_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/orderstate.dart';
import 'package:blue_witcher/Screens/restaurant_page/widgets/food_card2.dart';
import 'package:blue_witcher/Screens/restaurant_page/widgets/paymentAlert.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

Alert checkoutAlert(context, List<TableModel>? tableData) {
  OrderState myOrderState = Provider.of<OrderState>(context, listen: false);
  return Alert(
      padding: EdgeInsets.zero,
      context: context,
      style: AlertStyle(
          isCloseButton: false,
          isButtonVisible: true,
          backgroundColor: Color.fromRGBO(242, 251, 226, 1),
          alertPadding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h),
          overlayColor: Colors.transparent),
      content: Container(
        height: 55.h,
        width: 90.w,
        child: ListView.builder(
            itemCount: myOrderState.getOrder.length,
            itemBuilder: (ctx, index) {
              return FoodCard2(
                key: UniqueKey(),
                quantity: myOrderState.getOrder[index].quantity,
                imageUrl: myOrderState.getOrder[index].imageUrl,
                name: myOrderState.getOrder[index].name,
                price: myOrderState.getOrder[index].price,
                id: myOrderState.getOrder[index].id,
              );
            }),
      ),
      buttons: [
        DialogButton(
          width: 50.w,
          color: Color.fromRGBO(97, 125, 45, 1),
          onPressed: () {
            if (myOrderState.getItemsCount == 0) {
              Fluttertoast.showToast(msg: "There are no items in your cart. Please add some items first!!!");
              Navigator.of(context, rootNavigator: true).pop();
              return;
            }
            Navigator.of(context, rootNavigator: true).pop();
            paymentAlert(context, tableData);
          },
          child: Text(
            "Checkout",
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        )
      ]);
}
