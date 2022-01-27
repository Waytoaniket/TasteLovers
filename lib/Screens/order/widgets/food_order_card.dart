import 'package:blue_witcher/Screens/order/model/order_details_model.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

class FoodOrderCard extends StatefulWidget {
  final Data? data;
  final int? status;
  const FoodOrderCard({Key? key, required this.data, this.status}) : super(key: key);

  @override
  _FoodOrderCardState createState() => _FoodOrderCardState();
}

class _FoodOrderCardState extends State<FoodOrderCard> {
  double rate = 0;
  bool rated = false;

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
          Container(
            width: 10.h,
            height: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.h),
              child: FadeInImage(
                image: NetworkImage(
                  widget.data!.image != null
                      ? ApiProvider.imageBaseUrl + widget.data!.image!
                      : ApiProvider.imageBaseUrl,
                ),
                placeholder: AssetImage('assets/home/loader3.gif'),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/home/1.jpg", fit: BoxFit.cover);
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 6.h,
            width: 42.w,
            padding: EdgeInsets.only(left: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.data!.itemName!,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                Text(
                  "Quantity: ${widget.data!.itemQty}",
                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 6.w, top: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price: ${widget.data!.itemPrice}",
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                ),
                rated
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.1.w),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(1, 180, 96, 1),
                          borderRadius: BorderRadius.circular(1.w),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_half_rounded,
                              color: Colors.white,
                              size: 4.5.w,
                            ),
                            Text(
                              rate.toString(),
                              style: TextStyle(color: Colors.white, fontSize: 3.w),
                            )
                          ],
                        ),
                      )
                    : (widget.status == 3 && widget.data!.rating == null)
                        ? InkWell(
                            onTap: () {
                              showDialog(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.w),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(115, 167, 19, 0.6), borderRadius: BorderRadius.circular(2.w)),
                              child: Text(
                                "Rate",
                                style: TextStyle(fontSize: 10.sp, color: Colors.white),
                              ),
                            ),
                          )
                        : (widget.status == 3 && widget.data!.rating != null)
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.1.w),
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(1, 180, 96, 1),
                                  borderRadius: BorderRadius.circular(1.w),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star_half_rounded,
                                      color: Colors.white,
                                      size: 4.5.w,
                                    ),
                                    Text(
                                      widget.data!.rating.toString(),
                                      style: TextStyle(color: Colors.white, fontSize: 3.w),
                                    )
                                  ],
                                ),
                              )
                            : Container()
              ],
            ),
          )
        ],
      ),
    );
  }

  void showDialog(context) {
    Alert(
        padding: EdgeInsets.zero,
        context: context,
        style: AlertStyle(
            isCloseButton: false,
            isButtonVisible: true,
            backgroundColor: Color.fromRGBO(242, 251, 226, 1),
            alertPadding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h),
            overlayColor: Colors.transparent),
        content: Container(
          height: 15.h,
          width: 70.w,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: 5.h),
          child: RatingBar(
            initialRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            glow: false,
            itemCount: 5,
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star_rounded,
                color: Colors.amber,
              ),
              half: Icon(
                Icons.star_half_rounded,
                color: Colors.amber,
              ),
              empty: Icon(
                Icons.star_border_rounded,
                color: Colors.black,
              ),
            ),
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            onRatingUpdate: (val) {
              setState(() {
                rate = val;
              });
            },
          ),
        ),
        buttons: [
          DialogButton(
            width: 50.w,
            color: Color.fromRGBO(97, 125, 45, 1),
            onPressed: () async {
              EasyLoading.show(status: 'Loading Order Details...', dismissOnTap: false);

              Map<String, String> data = {"item_id": widget.data!.itemId.toString(), "rating": rate.toString()};
              await ApiProvider.updateRating(data).then(
                (response) {
                  if (response["result"] != null && response['result']) {
                    Fluttertoast.showToast(
                        msg: response['message'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1);
                    Navigator.of(context, rootNavigator: true).pop();
                    EasyLoading.dismiss();
                    setState(() {
                      rated = true;
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: response['message'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1);
                    EasyLoading.dismiss();
                  }
                },
              );
            },
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
            ),
          )
        ]).show();
  }
}
