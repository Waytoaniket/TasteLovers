import 'package:blue_witcher/Screens/booking/booking.dart';
import 'package:blue_witcher/Screens/home/home_page.dart';
import 'package:blue_witcher/Screens/main_page/widgets/bottom_navigation.dart';
import 'package:blue_witcher/Screens/offers/offer.dart';
import 'package:blue_witcher/Screens/order/order_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String id = "MainPage";
  final int? index;
  MainPage({Key? key, this.index}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index ?? 1;
  }

  List<Widget> pageList = [OrderPage(), HomePage(), OffersPage(), BookingPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pageList[_currentIndex], bottomNavigationBar: bottomNavigationBar(_currentIndex, onTabTapped));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
