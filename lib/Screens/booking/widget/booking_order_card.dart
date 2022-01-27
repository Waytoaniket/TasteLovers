import 'package:blue_witcher/Screens/booking/model/booking_details_model.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BookingOrderCard extends StatelessWidget {
  final Data? data;
  const BookingOrderCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.h,
      width: 100.w,
      padding: EdgeInsets.all(4.w),
      margin: EdgeInsets.all(0.5.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(2.w),
            bottomRight: Radius.circular(2.w),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0),
          ]),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 6.h,
              padding: EdgeInsets.only(left: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Table No: ${data!.tableNo}",
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Capacity: ${data!.tableCapacity}",
                    style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 6.w, top: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price: ${data!.totalPrice}",
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
