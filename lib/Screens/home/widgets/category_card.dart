import 'package:blue_witcher/Screens/restaurant_page/restaurant_page.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CategoryCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double? rating;
  final int? like;
  final int? id;
  final int? userId;

  const CategoryCard({Key? key, this.imageUrl, this.like, this.name, this.rating, this.id, this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    RestaurantState myState = Provider.of<RestaurantState>(context, listen: false);
    return InkWell(
      onTap: () async {
        EasyLoading.show(status: 'Loading...', dismissOnTap: false);
        var r = await myState.getData(userId);
        await myState.getTables(userId);
        await myState.getRestaurantImage(userId);
        await myState.getProductData(id);
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
            height: 14.h,
            width: 20.w,
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 6.h,
              width: 20.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
                color: Color.fromRGBO(196, 196, 196, 0.2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name!,
                    style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.star_half_rounded,
                          color: Colors.amber,
                        ),
                        Text(
                          rating.toString(),
                          style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                        ),
                        Text(
                          "|",
                          style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                        ),
                        Text(
                          like.toString(),
                          style: TextStyle(fontSize: 8.sp, color: Colors.grey),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              height: 20.w,
              width: 20.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
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
          )
        ],
      ),
    );
  }
}
