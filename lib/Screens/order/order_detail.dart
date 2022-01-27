import 'package:blue_witcher/Screens/order/model/order_details_model.dart';
import 'package:blue_witcher/Screens/order/widgets/food_order_card.dart';
import 'package:blue_witcher/Screens/order/widgets/order_detail_appbar.dart';
import 'package:blue_witcher/Screens/order/widgets/order_list.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

// List<Widget> foodOrderList = [
//   FoodOrderCard(
//     name: "Food name",
//     imageUrl: "assets/home/1.jpg",
//   ),
//   FoodOrderCard(
//     name: "Food name",
//     imageUrl: "assets/home/2.jpg",
//   ),
//   FoodOrderCard(
//     name: "Food name",
//     imageUrl: "assets/home/3.jpg",
//   ),
// ];

class OrderDetailPage extends StatefulWidget {
  static const String id = "OrderDetailPage";

  final String orderId;
  final int? status;
  OrderDetailPage({Key? key, required this.orderId, this.status}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  OrderDetailsModel? _orderDetailsModel;

  // List<Widget> orderDetailList = [
  //   OderDetailCard(),
  //   OderDetailCard(),
  //   OderDetailCard(),
  // ];

  void _getOrderDetails() async {
    EasyLoading.show(status: 'Loading Order Details...', dismissOnTap: false);
    var data = await ApiProvider.getOrderDetails(id: widget.orderId);
    _orderDetailsModel = OrderDetailsModel.fromJson(data);
    setState(() {});
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    _getOrderDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _orderDetailsModel == null ? Container() : orderDetailAppBar(id: _orderDetailsModel!.data![0].cartId),
          _orderDetailsModel == null
              ? Container()
              : Expanded(
                  child: ListView.builder(
                      itemCount: _orderDetailsModel!.data!.length,
                      itemBuilder: (ctx, index) {
                        return FoodOrderCard(
                          data: _orderDetailsModel!.data![index],
                          status: widget.status,
                        );
                      }),
                ),
          // orderList(orderDetailList)
        ],
      ),
    );
    // Scaffold(
    //   body: Column(
    //     children: [
    //       orderDetailAppBar(id: _orderDetailsModel!.data![0].cartId),
    //       orderList(foodOrderList)
    //     ],
    //   ),
    // );
  }
}
