import 'package:blue_witcher/Screens/confirm_order/confirm_order.dart';
import 'package:blue_witcher/Screens/restaurant_page/models/table_model.dart';
import 'package:blue_witcher/Screens/restaurant_page/state/orderstate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

paymentAlert(context, List<TableModel>? tableData) {
  TableModel? _selectedTableModel;
  Alert paymentAlertBox = Alert(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      context: context,
      closeFunction: () {
        Navigator.of(context, rootNavigator: true).pop(false);
      },
      style: AlertStyle(
          // isCloseButton: false,
          isButtonVisible: true,
          backgroundColor: Color.fromRGBO(242, 251, 226, 1),
          alertPadding: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h),
          overlayColor: Colors.transparent),
      content: StatefulBuilder(builder: (context, setState) {
        return Container(
          height: 30.h,
          width: 85.w,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.w),
              boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, -1.0), blurRadius: 4.0)]),
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20.h,
                  margin: EdgeInsets.only(top: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Table number", style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500)),
                          SizedBox(width: 5.sp),
                          tableData!.isEmpty
                              ? Text('No Table')
                              : Expanded(
                                  child: new DropdownButton<TableModel>(
                                    value: _selectedTableModel,
                                    onChanged: (TableModel? newValue) {
                                      setState(() {
                                        _selectedTableModel = newValue;
                                        context
                                            .read<OrderState>()
                                            .setTableNo(_selectedTableModel!.id!, _selectedTableModel!.tableNo!);
                                      });
                                    },
                                    hint: Text(
                                      "Select your table",
                                      style: new TextStyle(color: Colors.black),
                                    ),
                                    items: tableData.map((TableModel user) {
                                      return new DropdownMenuItem<TableModel>(
                                        value: user,
                                        child: new Text(
                                          "Table ${user.tableNo}",
                                          style: new TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                        ],
                      ),
                      Text(
                        "Total Items: ${context.read<OrderState>().getItemsCount}",
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Tax: 0",
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Total amount: ${context.read<OrderState>().getTotalAmount}",
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      onWillPopActive: true,
      buttons: [
        DialogButton(
          width: 50.w,
          color: Color.fromRGBO(97, 125, 45, 1),
          onPressed: () {
            if (_selectedTableModel == null)
              Fluttertoast.showToast(msg: "Please select your table number !!!");
            else
              Navigator.of(context, rootNavigator: true).pop(true);
          },
          child: Text(
            "Payment",
            style: TextStyle(color: Colors.white, fontSize: 15.sp),
          ),
        )
      ]);
  paymentAlertBox.show().then((value) {
    print(value);
    if (value == null || !value) return;

    Navigator.push(paymentAlertBox.context, MaterialPageRoute(builder: (ctx) => ConfirmOrder()));
  });
}
