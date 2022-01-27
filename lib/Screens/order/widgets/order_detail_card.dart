import 'package:blue_witcher/Screens/order/model/orders_model.dart';
import 'package:blue_witcher/Screens/order/order_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
// import 'package:intl/intl_browser.dart';

class OderDetailCard extends StatelessWidget {
  final Data data;
  const OderDetailCard({Key? key, required this.data}) : super(key: key);

  String getStatusTitle(int status) {
    switch (status) {
      case 0:
        return "Rejected";
      case 1:
        return "Confirmed";
      case 2:
        return "Pending";
      case 3:
        return "Completed";

      default:
        return "NA";
    }
  }

  Color getStatusColor(int status) {
    switch (status) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.yellow.shade800;
      case 3:
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => OrderDetailPage(
              orderId: data.cartId!,
              status: data.status,
            ),
          ),
        );
      },
      child: Container(
        height: 17.h,
        width: 96.w,
        margin: EdgeInsets.symmetric(vertical: 1.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.w),
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
                height: 7.5.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "Order Id: ${data.cartId}",
                                style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                              ),
                              Text(
                                "",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 4.w),
                          child: Text(
                            "${DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(data.createdAt!))}",
                            style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "No of items: ${data.items}",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          " ",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Total Price: ${data.totalPrice}",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Text(
                          "  ",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                  height: 5.h,
                  padding: EdgeInsets.only(left: 2.h),
                  color: Color.fromRGBO(125, 50, 45, 0.2),
                  child: Row(
                    children: [
                      Text(
                        "Status:",
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        getStatusTitle(data.status!),
                        style: TextStyle(fontSize: 11.sp, color: getStatusColor(data.status!)),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
