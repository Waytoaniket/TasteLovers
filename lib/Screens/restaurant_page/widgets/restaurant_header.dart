import 'package:blue_witcher/Screens/home/model/search_by_id_model.dart' as model;
import 'package:blue_witcher/Screens/restaurant_page/add_new_photo.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/Screens/restaurant_page/widgets/popup_menu_item.dart';
import 'package:blue_witcher/Screens/reviews/review.dart';
import 'package:blue_witcher/Screens/table_booking/table_booking.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

class RestaurantHeader extends StatelessWidget {
  const RestaurantHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantState restaurantState = Provider.of<RestaurantState>(context);
    List<model.Datum> restoData = restaurantState.dataList;
    List<model.Menu> menuList = restaurantState.menuList;
    return Container(
      height: 34.h,
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      decoration: BoxDecoration(
          color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 4.0)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 9.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${restoData.first.name}",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 1.h),
                        child: Text(
                          "Restaurant description",
                          style: TextStyle(fontSize: 11.sp),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 1.h),
                        child: Text(
                          "Restaurant address",
                          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                        ),
                      ),
                      PopUpMenuItems(menuList: menuList)
                    ],
                  ),
                ),
                Container(
                  height: 15.h,
                  width: 19.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.w),
                      boxShadow: [BoxShadow(color: Colors.black, offset: Offset(0.0, 0.0), blurRadius: 4.0)]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.w),
                    child: FadeInImage(
                      image: NetworkImage(ApiProvider.imageBaseUrl + restoData.first.restaurantImg!),
                      placeholder: AssetImage('assets/home/loader3.gif'),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return Image.asset("assets/home/1.jpg", fit: BoxFit.cover);
                      },
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 1.5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddNewPhoto(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(115, 167, 19, 0.2), boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(115, 167, 19, 0.05),
                        offset: Offset(0.0, 2.0),
                      ),
                    ]),
                    width: 26.w,
                    padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                          size: 3.5.h,
                        ),
                        Text(
                          "Photos",
                          style: TextStyle(fontSize: 11.sp),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TableBookingPage(
                        resName: restoData.first.name,
                        location: restoData.first.restaurantLocation,
                        resId: restoData.first.id.toString(),
                      ),
                    ),
                  ),
                  child: Container(
                    width: 30.w,
                    decoration: BoxDecoration(color: Color.fromRGBO(115, 167, 19, 0.2), boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(115, 167, 19, 0.05),
                        offset: Offset(0.0, 2.0),
                      ),
                    ]),
                    padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Transform.rotate(
                          angle: 90 * math.pi / 180,
                          child: Icon(
                            Icons.bookmark_add,
                            color: Colors.grey,
                            size: 3.5.h,
                          ),
                        ),
                        Text(
                          "Bookings",
                          style: TextStyle(fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(115, 167, 19, 0.2), boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(115, 167, 19, 0.05),
                        offset: Offset(0.0, 2.0),
                      ),
                    ]),
                    width: 28.5.w,
                    padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.groups,
                          color: Colors.grey,
                          size: 3.5.h,
                        ),
                        Text(
                          "Reviews",
                          style: TextStyle(fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
