import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget tableBookingAppBar() {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5.h, left: 2.h),
            child: Text(
              "Table Booking",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    ),
  );
}
