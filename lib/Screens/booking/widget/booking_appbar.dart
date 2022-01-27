import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget bookingAppBar(BuildContext context, Function getOrders, Function getHistory) {
  return Container(
    height: 12.h,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0),
      ],
    ),
    child: Container(
      padding: EdgeInsets.only(left: 2.h, right: 4.h, bottom: 1.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => getOrders(),
            child: Container(
              margin: EdgeInsets.only(top: 6.h, left: 1.h),
              child: Text(
                "Bookings",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => getHistory(),
                child: Image.asset(
                  "assets/order/history.png",
                  height: 3.h,
                  width: 3.h,
                ),
              ),
              Text(
                "History",
                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
              )
            ],
          )
        ],
      ),
    ),
  );
}
