import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

BottomNavigationBar bottomNavigationBar(int currentIndex, void onTabTapped(int index)) {
  return BottomNavigationBar(
    currentIndex: currentIndex, // this will be set when a new tab is tapped
    onTap: onTabTapped,
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    selectedFontSize: 12.sp,
    unselectedFontSize: 10.sp,
    selectedItemColor: Color.fromRGBO(115, 167, 19, 1),
    unselectedIconTheme: IconThemeData(color: Colors.black),
    items: [
      BottomNavigationBarItem(
        icon: new ImageIcon(
          AssetImage("assets/main/Purchase_Order.png"),
          size: 4.h,
        ),
        label: 'Order',
      ),
      BottomNavigationBarItem(
        icon: new ImageIcon(
          AssetImage("assets/main/Slippers.png"),
          size: 4.h,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: new ImageIcon(
          AssetImage("assets/main/Discount.png"),
          size: 4.h,
        ),
        label: 'Offer',
      ),
      BottomNavigationBarItem(
        icon: new ImageIcon(
          AssetImage("assets/main/Ebook.png"),
          size: 4.h,
        ),
        label: 'Booking',
      )
    ],
  );
}
