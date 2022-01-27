import 'package:blue_witcher/Screens/login/login.dart';
import 'package:blue_witcher/Screens/otp/otp.dart';
import 'package:blue_witcher/Screens/signup/widgets/inputfield.dart';
import 'package:blue_witcher/Screens/state/user_data_state.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:keyboard_actions/keyboard_actions_config.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatefulWidget {
  static const String id = 'SignUpPage';
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final FocusNode _nodeText1 = FocusNode();

  TextEditingController _phone = TextEditingController();
  bool isLoading = false;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            focusNode: _nodeText1,
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
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
                          "Register your mobile number",
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      KeyboardActions(
                        config: _buildConfig(context),
                        autoScroll: false,
                        child: Container(
                          height: 8.h,
                          margin: EdgeInsets.only(top: 4.h, left: 4.h, right: 4.h),
                          child: field(_nodeText1, _globalKey, _phone),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_globalKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Map<String, String> data = {'mobile': _phone.text};
                            ApiProvider.verifyMobile(data).then((response) {
                              if (response['status'] == 200) {
                                Fluttertoast.showToast(
                                    msg: response['message'],
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1);

                                Provider.of<UserDataState>(context, listen: false).updateMobileNumber(_phone.text);

                                Navigator.pushNamed(context, OtpPage.id);

                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: response['message'],
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1);
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            });
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => OtpPage(
                            //       phone: _phone.text,
                            //     ),
                            //   ),
                            // );
                          }
                        },
                        child: Container(
                          height: 5.h,
                          width: 35.w,
                          margin: EdgeInsets.only(top: 5.h),
                          color: Color.fromRGBO(97, 125, 45, 1),
                          alignment: Alignment.center,
                          child: Text(
                            "Get OTP",
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
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Login(),
                                    ),
                                  );
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
