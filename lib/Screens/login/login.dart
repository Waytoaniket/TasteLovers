import 'package:blue_witcher/Screens/forget_password/forget_password.dart';
import 'package:blue_witcher/Screens/login/widget/login_inputfield.dart';
import 'package:blue_witcher/Screens/main_page/main_page.dart';
import 'package:blue_witcher/Screens/signup/signup.dart';
import 'package:blue_witcher/Screens/state/user_data_state.dart';
import 'package:blue_witcher/constant.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  static const String id = 'LoginPage';
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _globalKey = GlobalKey();

  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText1,
        ),
        KeyboardActionsItem(
          focusNode: _nodeText2,
        )
      ],
    );
  }

  bool passwordNotVisible = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    UserDataState userdata = Provider.of<UserDataState>(context, listen: false);
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
                  height: 60.h,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      KeyboardActions(
                        config: _buildConfig(context),
                        autoScroll: false,
                        disableScroll: true,
                        child: Column(
                          children: [
                            Container(
                              height: 8.h,
                              margin: EdgeInsets.only(top: 4.h, left: 4.h, right: 4.h),
                              child: emailField(_nodeText1, _globalKey, _phone),
                            ),
                            Container(
                              height: 8.h,
                              margin: EdgeInsets.only(top: 2.h, left: 4.h, right: 4.h),
                              child: loginPasswordField(
                                  _nodeText2,
                                  passwordNotVisible ? Icons.visibility_off : Icons.visibility,
                                  _password,
                                  passwordNotVisible,
                                  changePasswordVisibility),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (_globalKey.currentState!.validate() && _password.text.isNotEmpty) {
                            setState(() {
                              isLoading = true;
                            });
                            var r = await ApiProvider.loginUser(
                              int.parse(_phone.text),
                              _password.text,
                            );
                            if (r['result']) {
                              print(r['data']['token']);
                              userdata.updateToken(r['token']);
                              userdata.updateEmail(r['data']['email']);
                              userdata.updateFirstName(r['data']['name']);
                              userdata.updateId(r['data']['id']);
                              userdata.updateLastName('');
                              userdata.updateLocation(r['data']['city']);
                              userdata.updateMobileNumber(r['data']['mob_number']);
                              userdata.updateProfileImage(r['data']['image'] ?? '');

                              await SharedPreferences.getInstance().then((value) {
                                value.setString("email", userdata.getUserData.email);
                                value.setString("token", userdata.getUserData.token);
                                value.setString("firstName", userdata.getUserData.firstName);
                                value.setString("lastName", userdata.getUserData.lastName);
                                value.setString("mobile", userdata.getUserData.mobile);
                                value.setString("city", userdata.getUserData.city);
                                value.setString("profileImage", userdata.getUserData.profileImageUrl);
                              });

                              Constants.token = r['token'];

                              Navigator.pushReplacementNamed(context, MainPage.id);
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Invalid data',
                                gravity: ToastGravity.BOTTOM,
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 3,
                              );
                            }
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: Container(
                          height: 5.h,
                          width: 35.w,
                          margin: EdgeInsets.only(top: 5.h),
                          color: Color.fromRGBO(97, 125, 45, 1),
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
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
                            Text("Forget Password? ", style: TextStyle(fontSize: 12.sp)),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, ForgetPassword.id);
                              },
                              child: Text(
                                "Click Here",
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
              Positioned(
                bottom: 8.h,
                left: 6.w,
                right: 6.w,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(bottom: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New User? ", style: TextStyle(fontSize: 12.sp)),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12.sp),
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

  void changePasswordVisibility() {
    setState(() {
      passwordNotVisible = !passwordNotVisible;
    });
  }
}
