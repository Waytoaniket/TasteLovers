import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PlaceOrderCard extends StatelessWidget {
  const PlaceOrderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      height: 32.h,
      width: 85.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.w),
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, -1.0), blurRadius: 4.0)]),
      child: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 13.h,
              margin: EdgeInsets.only(top: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Table number", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
                      Icon(Icons.arrow_drop_down_outlined)
                    ],
                  ),
                  Text(
                    "Total Items:",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Tax:",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Total amount:",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              height: 6.h,
              width: 75.w,
              color: Color.fromRGBO(97, 125, 45, 0.8),
              child: Center(
                child: Text(
                  "Place order",
                  style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
