import 'package:blue_witcher/Screens/main_page/main_page.dart';
import 'package:blue_witcher/Screens/registration/widgets/registration_input_field.dart';
import 'package:blue_witcher/Screens/state/user_data_state.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = "RegistrationPage";

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  final FocusNode _nodeText4 = FocusNode();
  final FocusNode _nodeText5 = FocusNode();

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
          focusNode: _nodeText5,
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
      ],
    );
  }

  String _state = "Select City";
  final _formKey = GlobalKey<FormState>();

  bool passwordNotVisible = true;
  bool confirmedPasswordNotVisible = true;
  bool isLoading = false;

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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 18.h,
                width: 100.w,
                alignment: Alignment.bottomLeft,
                color: Color.fromRGBO(115, 167, 19, 0.6),
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.w),
                child: Text(
                  "Create a new account",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowGlow();
                    return false;
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      width: 100.w,
                      height: 82.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/registration/background.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: KeyboardActions(
                        config: _buildConfig(context),
                        autoScroll: false,
                        child: Form(
                          key: _formKey,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 8.h,
                                  margin: EdgeInsets.only(bottom: 1.h),
                                  child: textInputField(_nodeText1, "First name", _firstNameController),
                                ),
                                Container(
                                  height: 8.h,
                                  margin: EdgeInsets.only(bottom: 1.h),
                                  child: textInputField(_nodeText2, "Last name", _lastNameController),
                                ),
                                Container(
                                  height: 8.h,
                                  margin: EdgeInsets.only(bottom: 1.h),
                                  child: emailInputField(_nodeText3, "Email", _emailController),
                                ),
                                Container(
                                  height: 8.h,
                                  margin: EdgeInsets.only(bottom: 1.h),
                                  child: passwordField(
                                      _nodeText4,
                                      passwordNotVisible ? Icons.visibility_off : Icons.visibility,
                                      _passwordController,
                                      passwordNotVisible,
                                      changePasswordVisibility),
                                ),
                                Container(
                                    height: 8.h,
                                    margin: EdgeInsets.only(bottom: 1.h),
                                    child: confirmPasswordField(
                                        _nodeText5,
                                        confirmedPasswordNotVisible ? Icons.visibility_off : Icons.visibility,
                                        _confirmPasswordController,
                                        _passwordController,
                                        confirmedPasswordNotVisible,
                                        changeConfirmedPasswordVisibility)),
                                Container(
                                  height: 6.5.h,
                                  margin: EdgeInsets.only(bottom: 6.h),
                                  child: getDropDownInput(_state, updateDropDownValue),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      Map<String, String> data = Map();
                                      data['name'] = _firstNameController.text + " " + _lastNameController.text;
                                      data['email'] = _emailController.text;
                                      data['city'] = _state;
                                      data['password'] = _passwordController.text;
                                      data['mobile'] = userdata.getUserData.mobile;

                                      ApiProvider.registerUser(data).then((response) async {
                                        print(response);
                                        if (response['status'] == 200 || response['result'] == true) {
                                          Fluttertoast.showToast(
                                              msg: response['message'],
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1);

                                          userdata.updateEmail(_emailController.text);
                                          userdata.updateFirstName(_firstNameController.text);
                                          userdata.updateLastName(_lastNameController.text);
                                          userdata.updateLocation(_state);

                                          await SharedPreferences.getInstance().then((value) {
                                            value.setString("email", userdata.getUserData.email);
                                            value.setString("token", userdata.getUserData.token);
                                            value.setString("firstName", userdata.getUserData.firstName);
                                            value.setString("lastName", userdata.getUserData.lastName);
                                            value.setString("mobile", userdata.getUserData.mobile);
                                            value.setString("city", userdata.getUserData.city);
                                          });

                                          Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
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
                                    }
                                  },
                                  child: Container(
                                    height: 5.h,
                                    width: 35.w,
                                    color: Color.fromRGBO(97, 125, 45, 1),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Next",
                                      style:
                                          TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateDropDownValue(String val) {
    setState(() {
      _state = val;
    });
  }

  void changePasswordVisibility() {
    setState(() {
      passwordNotVisible = !passwordNotVisible;
    });
  }

  void changeConfirmedPasswordVisibility() {
    setState(() {
      confirmedPasswordNotVisible = !confirmedPasswordNotVisible;
    });
  }
}
