import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget bookingDetailAppBar({String? id}) {
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
          Container(
            margin: EdgeInsets.only(top: 6.h, left: 1.h),
            child: Text(
              "Booking Id:  $id",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
          Text("")
        ],
      ),
    ),
  );
}
