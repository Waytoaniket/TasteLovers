import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

List<String> offerList = ["assets/home/LiciousCoupon.jpg", "assets/home/Zomato.jpg"];

Widget carousel() {
  return CarouselSlider(
    options: CarouselOptions(height: 16.h, autoPlay: true, viewportFraction: 1, autoPlayInterval: Duration(seconds: 5)),
    items: offerList.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return offerCard(i);
        },
      );
    }).toList(),
  );
}

Widget offerCard(String imageUrl) {
  return Container(
    height: 16.h,
    width: 88.w,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 2.0),
          blurRadius: 2.0,
        )
      ],
      image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.cover),
    ),
  );
}
