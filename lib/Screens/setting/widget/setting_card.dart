import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget settingCard(String icon, String text) {
  return Container(
    height: 10.h,
    margin: EdgeInsets.only(top: 0.5.w),
    padding: EdgeInsets.only(left: 4.w),
    decoration: BoxDecoration(
        color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)]),
    child: Row(
      children: [
        Image.asset(icon),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(fontSize: 12.sp),
        )
      ],
    ),
  );
}
