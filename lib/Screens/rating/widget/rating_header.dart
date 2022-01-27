import 'package:blue_witcher/Screens/home/model/search_by_id_model.dart' as model;
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RatingHeader extends StatelessWidget {
  const RatingHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantState restaurantState = Provider.of<RestaurantState>(context);
    List<model.Datum> restoData = restaurantState.dataList;
    return Container(
      height: 29.h,
      padding: EdgeInsets.symmetric(horizontal: 2.h),
      decoration: BoxDecoration(
          color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 4.0)]),
      child: Container(
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
    );
  }
}
