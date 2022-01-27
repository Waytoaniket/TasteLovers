import 'package:blue_witcher/Screens/table_booking/model/drop_list_model.dart';
import 'package:blue_witcher/Screens/table_booking/state/table_state.dart';
import 'package:blue_witcher/Screens/table_booking/widget/datepicker.dart';
import 'package:blue_witcher/Screens/table_booking/widget/file%20select_drop_list.dart';
import 'package:blue_witcher/Screens/table_booking/widget/table_booking_appbar.dart';
import 'package:blue_witcher/Screens/table_booking/widget/text_field.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TableBookingPage extends StatefulWidget {
  static const String id = "TableBookingPage";
  final String? resName;
  final String? location;
  final String? resId;

  TableBookingPage({Key? key, this.resName, this.location, this.resId}) : super(key: key);

  @override
  _TableBookingPageState createState() => _TableBookingPageState();
}

class _TableBookingPageState extends State<TableBookingPage> {
  TextEditingController dateController = TextEditingController();
  TextEditingController _cont = TextEditingController();
  final _couponFormKey = GlobalKey<FormState>();
  final FocusNode _nodeText1 = FocusNode();
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText1,
        )
      ],
    );
  }

  OptionItem optionItemSelected = OptionItem(id: null, title: "Choose Table");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TableState>(context, listen: false).getData(widget.resId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          tableBookingAppBar(),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowGlow();
                return false;
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.resName!,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        widget.location!,
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      DatePicker(dateController: dateController),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              'Choose Table',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Consumer<TableState>(builder: (_, tableState, child) {
                            print(tableState.listOptionItems);
                            return Container(
                              width: 50.w,
                              child: new SelectDropList(
                                this.optionItemSelected,
                                tableState.listOptionItems,
                                Colors.black,
                                (optionItem) {
                                  optionItemSelected = optionItem;
                                  setState(() {});
                                },
                              ),
                            );
                          })
                        ],
                      ),
                      KeyboardActions(
                        config: _buildConfig(context),
                        autoScroll: false,
                        child: Form(
                          key: _couponFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5.h),
                              Text(
                                'Apply Coupon',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              textfeild(_cont, context),
                              SizedBox(height: 0.5.h),
                              Consumer<TableState>(builder: (_, couponState, child) {
                                return InkWell(
                                  onTap: () {
                                    if (_couponFormKey.currentState!.validate()) {
                                      couponState.applyCoupon(_cont.text);
                                    }
                                  },
                                  child: Container(
                                    height: 4.5.h,
                                    width: 20.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.sp),
                                      color: Color(0xFF617D2D),
                                    ),
                                    child: couponState.loadingCoupon
                                        ? Container(
                                            height: 2.h,
                                            width: 2.h,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : couponState.couponVaild
                                            ? Icon(
                                                Icons.verified_outlined,
                                                color: Colors.white,
                                              )
                                            : Text(
                                                'Apply',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      InkWell(
                        onTap: () {
                          if (dateController.text.isNotEmpty && optionItemSelected.id != null) {
                            Provider.of<TableState>(context, listen: false).bookTable(context, widget.resId,
                                [optionItemSelected.id], Provider.of<TableState>(context, listen: false).offerPrice);
                          } else {
                            Fluttertoast.showToast(
                              msg: "Fill All Fields",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                            );
                          }
                        },
                        child: Container(
                          height: 6.h,
                          width: 100.w,
                          margin: EdgeInsets.symmetric(horizontal: 6.w),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(5.sp),
                            color: Color(0xFF617D2D),
                          ),
                          child: Text(
                            'BOOK',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
