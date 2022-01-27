import 'package:blue_witcher/Screens/restaurant_page/restaurant_page.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/orderstate.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OfferCard extends StatelessWidget {
  final String? imageUrl;
  final int? offerId;
  final int? restaurantId;
  final String? coupon;
  final int? offerPrice;
  final String? restaurantName;
  final String? itemName;
  final int? itemId;
  const OfferCard({
    Key? key,
    this.coupon,
    this.imageUrl,
    this.itemId,
    this.itemName,
    this.offerId,
    this.offerPrice,
    this.restaurantId,
    this.restaurantName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        RestaurantState myState = Provider.of<RestaurantState>(context, listen: false);

        Provider.of<OrderState>(context, listen: false).clear();

        if (itemId == null) {
          EasyLoading.show(status: 'Loading...', dismissOnTap: false);

          var r = await myState.getData(restaurantId);
          await myState.getTables(restaurantId);
          await myState.getRestaurantImage(restaurantId);
          EasyLoading.dismiss();
          if (r) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RestaurantPage(),
              ),
            );
          }
        } else {
          EasyLoading.show(status: 'Loading...', dismissOnTap: false);
          var r = await myState.getData(restaurantId);
          await myState.getTables(restaurantId);
          await myState.getRestaurantImage(restaurantId);
          await myState.getProductData(itemId);
          EasyLoading.dismiss();
          if (r) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RestaurantPage(),
              ),
            );
          }
        }
      },
      child: Container(
        width: 100.w,
        height: 21.h,
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2.w),
          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)],
        ),
        child: Column(
          children: [
            Container(
              height: 15.h,
              width: 100.w,
              child: Container(
                  margin: EdgeInsets.only(top: 1.h, bottom: 3.h, left: 2.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FadeInImage(
                        image: NetworkImage(Constants.imageBaseUrl + imageUrl!),
                        placeholder: AssetImage('assets/home/loader3.gif'),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            "assets/home/1.jpg",
                            fit: BoxFit.cover,
                            height: 15.h,
                            width: 15.h,
                          );
                        },
                        fit: BoxFit.cover,
                        height: 15.h,
                        width: 12.h,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurantName!,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              if (itemId != null)
                                Text(
                                  itemName.toString(),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 6.5.h,
                        width: 28.w,
                        padding: EdgeInsets.all(3.w),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 15, 0, 0.2),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(2.w),
                            bottomLeft: Radius.circular(2.w),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              offerPrice.toString() + "%",
                              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "off",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
            Container(
              height: 5.h,
              width: 100.w,
              color: Color.fromRGBO(255, 15, 0, 0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Use Code: ",
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    coupon.toString(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(54, 79, 9, 1),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
