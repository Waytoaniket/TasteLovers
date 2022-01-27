import 'package:blue_witcher/Screens/login/login.dart';
import 'package:blue_witcher/Screens/otp/widgets/inputfield.dart';
import 'package:blue_witcher/Screens/registration/registration.dart';
import 'package:blue_witcher/Screens/setting/setting.dart';
import 'package:blue_witcher/Screens/state/user_data_state.dart';
import 'package:blue_witcher/constant.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class VerifyOtpPage extends StatefulWidget {
  static const String id = 'VerifyOtpPage';
  final String? phone;

  const VerifyOtpPage({Key? key, this.phone}) : super(key: key);

  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  TextEditingController otpFirst = TextEditingController();
  TextEditingController otpSecond = TextEditingController();
  TextEditingController otpThird = TextEditingController();
  TextEditingController otpFourth = TextEditingController();
  bool isLoading = false;

  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  final FocusNode _nodeText4 = FocusNode();
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            focusNode: _nodeText1,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => node.nextFocus(),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
            ],
          ),
          KeyboardActionsItem(
            focusNode: _nodeText2,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => node.nextFocus(),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
            ],
          ),
          KeyboardActionsItem(
            focusNode: _nodeText3,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => node.nextFocus(),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
            ],
          ),
          KeyboardActionsItem(
            focusNode: _nodeText4,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => node.unfocus(),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Done",
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
            ],
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    UserDataState userdata = Provider.of<UserDataState>(context, listen: false);
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: Color.fromRGBO(115, 167, 19, 0.6),
        ),
        inAsyncCall: isLoading,
        child: Container(
          height: 100.h,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 32.h,
                    color: Color.fromRGBO(115, 167, 19, 0.6),
                  ),
                  Expanded(child: Container(child: null))
                ],
              ),
              Positioned(
                top: 20.h,
                left: 6.w,
                right: 6.w,
                child: Container(
                  height: 55.h,
                  width: 88.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.w),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, -4.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 11.h,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Enter the OTP sent to your phone number ",
                          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      KeyboardActions(
                        config: _buildConfig(context),
                        autoScroll: false,
                        child: Container(
                          margin: EdgeInsets.only(top: 4.h, left: 6.h, right: 6.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              otpField(_nodeText1, context, otpFirst),
                              otpField(_nodeText2, context, otpSecond),
                              otpField(_nodeText3, context, otpThird),
                              otpField(_nodeText4, context, otpFourth)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (otpFirst.text != "" &&
                              otpSecond.text != "" &&
                              otpThird.text != "" &&
                              otpFourth.text != "") {
                            Map<String, String> data = {
                              'mobile': widget.phone!,
                              'otp': otpFirst.text + otpSecond.text + otpThird.text + otpFourth.text
                            };
                            setState(() {
                              isLoading = true;
                            });
                            ApiProvider.verifyNewOtp(data).then((response) async {
                              if (response['result'] != null && response['result']) {
                                userdata.updateMobileNumber(widget.phone!);

                                Fluttertoast.showToast(
                                    msg: response['message'],
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1);

                                Navigator.pop(context);

                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: response['message'],
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1);
                                otpFirst.clear();
                                otpSecond.clear();
                                otpThird.clear();
                                otpFourth.clear();
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Enter All Number',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1);
                          }
                        },
                        child: Container(
                          height: 5.h,
                          width: 35.w,
                          margin: EdgeInsets.only(top: 7.h),
                          color: Color.fromRGBO(97, 125, 45, 1),
                          alignment: Alignment.center,
                          child: Text(
                            "Verify",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.only(bottom: 1.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already registered? ", style: TextStyle(fontSize: 12.sp)),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, Login.id);
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
