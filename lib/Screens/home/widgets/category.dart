import 'package:blue_witcher/Screens/home/model/home_data_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/Screens/home/widgets/category_card.dart';
import 'package:blue_witcher/Screens/home/widgets/offer_card.dart';
import 'package:blue_witcher/Screens/home/widgets/restaurant_card.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

import 'package:sizer/sizer.dart';

Widget categorySection(
  BuildContext context,
  List<Restaurant> restaurantList,
  List<Papular> trendingList,
  List<Papular> papularList,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      carousel(),
      Container(
        margin: EdgeInsets.symmetric(vertical: 2.h),
        child: Text(
          "Trending now",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ),
      Container(
        height: 14.h,
        padding: EdgeInsets.only(left: 1.w),
        child: trendingList.isEmpty
            ? Center(
                child: Text('No Data'),
              )
            : ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    name: "${trendingList[index].itemName}",
                    rating: trendingList[index].avgRating,
                    like: trendingList[index].noOfRating,
                    imageUrl: ApiProvider.imageBaseUrl + trendingList[index].itemImg!,
                    id: trendingList[index].id,
                    userId: trendingList[index].userId,
                  );
                },
                separatorBuilder: (_, i) {
                  return SizedBox(
                    width: 3.8.w,
                  );
                },
                itemCount: trendingList.length),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 2.h),
        child: Text(
          "Popular near you",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ),
      Container(
        height: 14.h,
        padding: EdgeInsets.only(left: 1.w),
        child: papularList.isEmpty
            ? Center(
                child: Text('No Data'),
              )
            : ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    name: "${papularList[index].itemName}",
                    rating: papularList[index].avgRating,
                    like: papularList[index].noOfRating,
                    imageUrl: ApiProvider.imageBaseUrl + papularList[index].itemImg!,
                    id: papularList[index].id,
                    userId: papularList[index].userId,
                  );
                },
                separatorBuilder: (_, i) {
                  return SizedBox(
                    width: 3.8.w,
                  );
                },
                itemCount: papularList.length),
      ),
      SizedBox(height: 4.h),
      Container(
        child: Text(
          "Restaurants near you",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
        ),
      ),
      ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return restaurantList.isEmpty
                ? Center(
                    child: Text('No Data'),
                  )
                : RestaurantCard(
                    imageUrl: ApiProvider.imageBaseUrl + restaurantList[index].restaurantImg!,
                    name: "${restaurantList[index].name}",
                    rating: restaurantList[index].avgRating,
                    like: restaurantList[index].noOfRating,
                    id: restaurantList[index].id,
                  );
          },
          separatorBuilder: (_, i) {
            return SizedBox(
              height: 6.h,
            );
          },
          itemCount: restaurantList.length),
      SizedBox(
        height: 6.h,
      )
    ],
  );
}
