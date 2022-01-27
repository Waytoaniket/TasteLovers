import 'package:blue_witcher/Screens/booking/model/booking_details_model.dart';
import 'package:blue_witcher/Screens/booking/widget/booking_card.dart';
import 'package:blue_witcher/Screens/booking/widget/booking_detail_appbar.dart';
import 'package:blue_witcher/Screens/booking/widget/booking_order_card.dart';
import 'package:blue_witcher/Screens/order/model/order_details_model.dart';
import 'package:blue_witcher/Screens/order/widgets/food_order_card.dart';
import 'package:blue_witcher/Screens/order/widgets/order_detail_appbar.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BookingDetailPage extends StatefulWidget {
  static const String id = "BookingDetailPage";

  final String orderId;
  BookingDetailPage({Key? key, required this.orderId}) : super(key: key);

  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> {
  BookingDetailsModel? _bookingDetailsModel;

  void _getBookingDetails() async {
    EasyLoading.show(status: 'Loading Order Details...', dismissOnTap: false);
    var data = await ApiProvider.getBookingDetail({"order_id": widget.orderId});
    _bookingDetailsModel = BookingDetailsModel.fromJson(data);
    setState(() {});
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    _getBookingDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _bookingDetailsModel == null ? Container() : bookingDetailAppBar(id: _bookingDetailsModel!.data![0].cartId),
          _bookingDetailsModel == null
              ? Container()
              : Expanded(
                  child: ListView.builder(
                      itemCount: _bookingDetailsModel!.data!.length,
                      itemBuilder: (ctx, index) {
                        return BookingOrderCard(data: _bookingDetailsModel!.data![index]);
                      }),
                ),
        ],
      ),
    );
  }
}
