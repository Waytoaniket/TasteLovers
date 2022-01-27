import 'package:blue_witcher/Screens/forget_password/widget/passwrod_text_field.dart';
import 'package:blue_witcher/Screens/login/login.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

class SavePassword extends StatefulWidget {
  static const String id = 'savePassword';
  final String mobile;
  const SavePassword({Key? key, required this.mobile}) : super(key: key);

  @override
  _SavePasswordState createState() => _SavePasswordState();
}

class _SavePasswordState extends State<SavePassword> {
  TextEditingController _password = TextEditingController();
  TextEditingController _cnfpassword = TextEditingController();
  bool passwordNotVisible = true;
  bool cnfpasswordNotVisible = true;
  bool isLoading = false;
  void changePasswordVisibility() {
    setState(() {
      passwordNotVisible = !passwordNotVisible;
    });
  }

  void changeCnfPasswordVisibility() {
    setState(() {
      cnfpasswordNotVisible = !cnfpasswordNotVisible;
    });
  }

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
                          "Make Password",
                          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        height: 8.h,
                        margin: EdgeInsets.only(top: 2.h, left: 4.h, right: 4.h),
                        child: forgetPasswordField(passwordNotVisible ? Icons.visibility_off : Icons.visibility,
                            _password, passwordNotVisible, changePasswordVisibility),
                      ),
                      Container(
                        height: 8.h,
                        margin: EdgeInsets.only(top: 2.h, left: 4.h, right: 4.h),
                        child: cnfforgetPasswordField(cnfpasswordNotVisible ? Icons.visibility_off : Icons.visibility,
                            _cnfpassword, cnfpasswordNotVisible, changeCnfPasswordVisibility),
                      ),
                      InkWell(
                        onTap: () async {
                          if (_password.text.isNotEmpty &&
                              _cnfpassword.text.isNotEmpty &&
                              _cnfpassword.text == _password.text) {
                            setState(() {
                              isLoading = true;
                            });
                            var r = await ApiProvider.saveNewPassword(widget.mobile, _password.text);

                            if (r) {
                              Navigator.pushNamed(context, Login.id);
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Something went wrong',
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 3,
                              );
                            }
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: 'Password not match/empty',
                              gravity: ToastGravity.BOTTOM,
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 3,
                            );
                          }
                        },
                        child: Container(
                          height: 5.h,
                          width: 35.w,
                          margin: EdgeInsets.only(top: 5.h),
                          color: Color.fromRGBO(97, 125, 45, 1),
                          alignment: Alignment.center,
                          child: Text(
                            "Save",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                        ),
                      ),
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
