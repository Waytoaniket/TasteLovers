import 'package:blue_witcher/Screens/forget_password/save_password.dart';
import 'package:blue_witcher/Screens/forget_password/widget/passwrod_text_field.dart';
import 'package:blue_witcher/Screens/signup/signup.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

class ForgetPassword extends StatefulWidget {
  static const String id = 'ForgetPasswordPage';
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _phone = TextEditingController();
  TextEditingController otpFirst = TextEditingController();
  TextEditingController otpSecond = TextEditingController();
  TextEditingController otpThird = TextEditingController();
  TextEditingController otpFourth = TextEditingController();
  bool passwordNotVisible = true;
  bool isLoading = false;
  int check = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  height: 50.h,
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
                          check == 0 ? "Enter your Number" : "Enter OTP",
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      check == 0
                          ? Container(
                              height: 8.h,
                              margin: EdgeInsets.only(top: 4.h, left: 4.h, right: 4.h),
                              child: passwordPhoneField(_globalKey, _phone),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 4.h, left: 6.h, right: 6.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  otpFieldForgetPassword(context, otpFirst),
                                  otpFieldForgetPassword(context, otpSecond),
                                  otpFieldForgetPassword(context, otpThird),
                                  otpFieldForgetPassword(context, otpFourth)
                                ],
                              ),
                            ),
                      InkWell(
                        onTap: () async {
                          if (check == 0) {
                            setState(() {
                              isLoading = true;
                            });
                            if (_globalKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              var r = await ApiProvider.forgetPassword(_phone.text);

                              if (r) {
                                check = 1;
                                Fluttertoast.showToast(
                                  msg: 'OTP send to the number',
                                  gravity: ToastGravity.BOTTOM,
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 2,
                                );
                                setState(() {});
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Sign Up First!',
                                  gravity: ToastGravity.BOTTOM,
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 2,
                                );
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else if (check == 1) {
                            if (otpFirst.text != "" &&
                                otpSecond.text != "" &&
                                otpThird.text != "" &&
                                otpFourth.text != "") {
                              setState(() {
                                isLoading = true;
                              });
                              var r = await ApiProvider.verifyForgetPassword(
                                  _phone.text, otpFirst.text + otpSecond.text + otpThird.text + otpFourth.text);
                              if (r) {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => SavePassword(mobile: _phone.text)));
                              } else {
                                Fluttertoast.showToast(
                                  msg: 'Wrong OTP',
                                  gravity: ToastGravity.BOTTOM,
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 3,
                                );
                              }
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        child: Container(
                          height: 5.h,
                          width: 35.w,
                          margin: EdgeInsets.only(top: 5.h),
                          color: Color.fromRGBO(97, 125, 45, 1),
                          alignment: Alignment.center,
                          child: Text(
                            check == 0 ? "Get OTP" : "Verify OTP",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                        ),
                      ),
                      Container(
                        height: 12.h,
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: 1.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New User? ", style: TextStyle(fontSize: 12.sp)),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, SignUpPage.id);
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12.sp),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
