import 'package:blue_witcher/Screens/order/model/orders_model.dart';
import 'package:blue_witcher/Screens/order/widgets/order_appbar.dart';
import 'package:blue_witcher/Screens/order/widgets/order_detail_card.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class OrderPage extends StatefulWidget {
  static const String id = "OrderPage";
  OrderPage({Key? key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrdersModel? _ordersModel;

  // List<Widget> orderDetailList = [
  //   OderDetailCard(),
  //   OderDetailCard(),
  //   OderDetailCard(),
  // ];

  void getOrders() async {
    EasyLoading.show(status: 'Loading Orders...', dismissOnTap: false);
    var data = await ApiProvider.getOrders();
    _ordersModel = OrdersModel.fromJson(data);
    setState(() {});
    EasyLoading.dismiss();
  }

  void getHistory() async {
    EasyLoading.show(status: 'Loading Orders...', dismissOnTap: false);
    ApiProvider.getOrderHistory().then((response) {
      if (response != null && response['result']) {
        setState(() {
          _ordersModel = OrdersModel.fromJson(response);
        });
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
      }
    });
  }

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          orderAppBar(context, getOrders, getHistory),
          _ordersModel == null
              ? Container()
              : Expanded(
                  child: ListView.builder(
                      itemCount: _ordersModel!.data!.length,
                      itemBuilder: (ctx, index) {
                        return OderDetailCard(data: _ordersModel!.data![index]);
                      }),
                ),
        ],
      ),
    );
  }
}
