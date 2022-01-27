import 'package:blue_witcher/Screens/home/model/search_by_id_model.dart';
import 'package:blue_witcher/Screens/home/model/search_list_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/restaurant_state.dart';
import 'package:blue_witcher/Screens/home/state/search_state.dart';
import 'package:blue_witcher/Screens/restaurant_page/restaurant_page.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Widget searchList(List<SearchItem> searchList, BuildContext context) {
  RestaurantState myState = Provider.of<RestaurantState>(context, listen: false);
  SearchState searchState = Provider.of<SearchState>(context, listen: false);
  return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(
        left: 12.w,
      ),
      itemBuilder: (_, index) {
        // return Text(searchList[index].itemName.toString());
        return InkWell(
          onTap: () async {
            if (searchState.filterByRestaurant) {
              EasyLoading.show(status: 'Loading...', dismissOnTap: false);
              var r = await myState.getData(searchList[index].id);
              EasyLoading.dismiss();
              if (r) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RestaurantPage(),
                  ),
                );
              } else {
                Fluttertoast.showToast(
                  msg: 'No Data Found',
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 3,
                );
              }
            } else {
              print('product');
              EasyLoading.show(status: 'Loading...', dismissOnTap: false);
              var r = await myState.getProductData(searchList[index].id);
              EasyLoading.dismiss();
              if (r) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RestaurantPage(),
                  ),
                );
              } else {
                Fluttertoast.showToast(
                  msg: 'No Data Found',
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_SHORT,
                  timeInSecForIosWeb: 3,
                );
              }
            }
          },
          child: Container(
            height: 6.h,
            alignment: Alignment.centerLeft,
            child: Text(
              searchList[index].name!,
              style: TextStyle(
                fontSize: 14.sp,
              ),
            ),
          ),
        );
      },
      itemCount: searchList.length);
}
