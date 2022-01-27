import 'package:blue_witcher/Screens/restaurant_page/models/table_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/orderstate.dart';
import 'package:blue_witcher/Screens/restaurant_page/widgets/checkoutAlert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/src/provider.dart';
import 'package:sizer/sizer.dart';

class PlaceOrderWidget extends StatelessWidget {
  final Function intializeData;

  const PlaceOrderWidget({
    Key? key,
    required this.tableData,
    required this.intializeData,
  }) : super(key: key);

  final List<TableModel>? tableData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.h, vertical: 3.w),
      decoration: BoxDecoration(
          color: Color.fromRGBO(242, 251, 226, 1),
          borderRadius: BorderRadius.circular(2.w),
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${context.watch<OrderState>().getItemsCount} Items added",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp),
          ),
          InkWell(
            onTap: () {
              if (context.read<OrderState>().getItemsCount == 0) {
                Fluttertoast.showToast(msg: "There are no items in your cart !!!");
                return;
              }
              checkoutAlert(context, tableData).show().then((value) {
                this.intializeData();
              });
            },
            child: Container(
              width: 30.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Color.fromRGBO(97, 125, 45, 1),
                borderRadius: BorderRadius.circular(2.5.h),
              ),
              child: Center(
                child: Text(
                  "Place Order",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 10.sp),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
