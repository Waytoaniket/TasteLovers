import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget orfferAppBar(BuildContext context) {
  return Container(
    height: 12.h,
    width: 100.h,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0),
      ],
    ),
    child: Container(
      margin: EdgeInsets.only(top: 6.5.h, left: 3.h),
      child: Text(
        "Offers",
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
