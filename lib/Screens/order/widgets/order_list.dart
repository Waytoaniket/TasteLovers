import 'package:blue_witcher/Screens/order/widgets/food_order_card.dart';
import 'package:blue_witcher/Screens/order/widgets/order_detail_card.dart';
// import 'package:blue_witcher/Screens/order/widgets/place_order_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

Widget orderList(cardList) {
  return Expanded(
    child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 2.h),
        child: Column(children: cardList),
      ),
    ),
  );
}
