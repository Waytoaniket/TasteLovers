import 'package:blue_witcher/Screens/restaurant_page/state/orderstate.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/Screens/restaurant_page/restaurant_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RestaurantCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? rating;
  final int? like;
  final int? id;
  const RestaurantCard({Key? key, this.imageUrl, this.like, this.name, this.rating, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantState myState = Provider.of<RestaurantState>(context, listen: false);
    return Container(
      height: 38.h,
      child: InkWell(
        onTap: () async {
          EasyLoading.show(status: 'Loading...', dismissOnTap: false);
          Provider.of<OrderState>(context, listen: false).clear();

          var r = await myState.getData(id);
          await myState.getTables(id);
          await myState.getRestaurantImage(id);
          EasyLoading.dismiss();
          if (r) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RestaurantPage(),
              ),
            );
          }
        },
        child: Stack(
          children: [
            Container(
              height: 38.h,
              width: 100.w,
            ),
            Positioned(
              top: 0,
              child: Container(
                height: 31.h,
                width: 91.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2.h),
                  child: FadeInImage(
                    image: NetworkImage(imageUrl!),
                    placeholder: AssetImage('assets/home/loader3.gif'),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset("assets/home/1.jpg", fit: BoxFit.cover);
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 5.h,
              right: 5.h,
              child: Container(
                height: 14.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.h),
                  boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 3.0), blurRadius: 4.0)],
                  color: Colors.white,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 40.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.star_half_rounded,
                                color: Colors.amber,
                                size: 8.w,
                              ),
                              Text(rating.toString(), style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                              Text("|"),
                              Icon(Icons.groups, size: 7.w, color: Colors.grey),
                              Text(like.toString(), style: TextStyle(fontSize: 14.sp, color: Colors.grey))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
