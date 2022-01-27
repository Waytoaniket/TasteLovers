import 'package:blue_witcher/Screens/booking/model/booking_model.dart';
import 'package:blue_witcher/Screens/booking/widget/booking_appbar.dart';
import 'package:blue_witcher/Screens/booking/widget/booking_card.dart';
import 'package:blue_witcher/Screens/order/widgets/order_appbar.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BookingPage extends StatefulWidget {
  static const String id = "BookingPage";
  BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  BookingModel? _bookingModel;

  // List<Widget> orderDetailList = [
  //   OderDetailCard(),
  //   OderDetailCard(),
  //   OderDetailCard(),
  // ];

  void getTablesBooking() async {
    EasyLoading.show(status: 'Loading Orders...', dismissOnTap: false);
    var data = await ApiProvider.getTablesBooking();
    _bookingModel = BookingModel.fromJson(data);
    setState(() {});
    EasyLoading.dismiss();
  }

  void getHistory() async {
    EasyLoading.show(status: 'Loading Orders...', dismissOnTap: false);
    ApiProvider.getBookingHistory().then((response) {
      if (response != null && response['result']) {
        setState(() {
          _bookingModel = BookingModel.fromJson(response);
        });
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
      }
    });
  }

  @override
  void initState() {
    getTablesBooking();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          bookingAppBar(context, getTablesBooking, getHistory),
          _bookingModel == null
              ? Container()
              : Expanded(
                  child: ListView.builder(
                      itemCount: _bookingModel!.data!.length,
                      itemBuilder: (ctx, index) {
                        return BookingCard(data: _bookingModel!.data![index]);
                      }),
                ),
        ],
      ),
    );
  }
}
