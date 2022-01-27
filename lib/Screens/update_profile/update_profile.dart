import 'dart:io';

import 'package:blue_witcher/Screens/state/user_data_state.dart';
import 'package:blue_witcher/Screens/update_profile/verifiy_otp.dart';
import 'package:blue_witcher/Screens/update_profile/widget/profile_input_fields.dart';
import 'package:blue_witcher/constant.dart';
import 'package:blue_witcher/services/webservices.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class UpdatePtofile extends StatefulWidget {
  static const String id = "UpdatePtofile";

  const UpdatePtofile({Key? key}) : super(key: key);

  @override
  _UpdatePtofileState createState() => _UpdatePtofileState();
}

class _UpdatePtofileState extends State<UpdatePtofile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
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
      ],
    );
  }

  final _formKey = GlobalKey<FormState>();
  UserDataState userData = UserDataState();
  bool isLoading = false;
  final picker = ImagePicker();
  String profileImage = "";

  @override
  void initState() {
    userData = Provider.of<UserDataState>(context, listen: false);

    _nameController.text = userData.getUserData.firstName;
    _emailController.text = userData.getUserData.email;
    _phoneController.text = userData.getUserData.mobile;
    _cityController.text = userData.getUserData.city;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          color: Color.fromRGBO(115, 167, 19, 0.6),
        ),
        inAsyncCall: isLoading,
        child: Container(
          child: SingleChildScrollView(
            child: KeyboardActions(
              config: _buildConfig(context),
              autoScroll: false,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10.h,
                      margin: EdgeInsets.only(top: 2.h),
                      padding: EdgeInsets.only(left: 6.w, top: 2.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)]),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Update Profile",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 16.h,
                          width: 16.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 2.0)]),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.h),
                            child: Consumer<UserDataState>(
                              builder: (_, userstate, child) {
                                return FadeInImage(
                                  image: userstate.getUserData.profileImageUrl != "" && profileImage == ""
                                      ? NetworkImage(Constants.imageBaseUrl + userstate.getUserData.profileImageUrl)
                                      : profileImage != ""
                                          ? FileImage(File(profileImage)) as ImageProvider
                                          : AssetImage("assets/home/noprofile.png"),
                                  placeholder: AssetImage('assets/home/loader3.gif'),
                                  imageErrorBuilder: (context, error, stackTrace) {
                                    return Image.asset("assets/home/noprofile.png", fit: BoxFit.cover);
                                  },
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 6.h,
                          right: 6.h,
                          child: InkWell(
                            onTap: () => getImage(),
                            child: Icon(Icons.camera_alt, size: 4.h, color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 4.h),
                    profileNameOrEmailField(
                        _nodeText1, "Your Name", _nameController, Icons.person, InputFieldType.Name),
                    SizedBox(height: 2.h),
                    profilePhoneField(_nodeText2, "Your mobile number", _phoneController, Icons.phone, updateNumber),
                    SizedBox(height: 2.h),
                    profileNameOrEmailField(
                        _nodeText3, "Your E-mail address", _emailController, Icons.mail, InputFieldType.Email),
                    SizedBox(height: 2.h),
                    profileNameOrEmailField(
                        _nodeText4, "Your city", _cityController, Icons.location_city, InputFieldType.City),
                    SizedBox(height: 4.h),
                    InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          Map<String, String> data = {
                            "name": _nameController.text,
                            "email": _emailController.text,
                            "city": _cityController.text
                          };
                          ApiProvider.updateProfile(data, new File(profileImage)).then((response) {
                            if (response['result'] != null && response['result']) {
                              userData.updateEmail(response['data']['email'] != null ? response['data']['email'] : "");
                              userData
                                  .updateFirstName(response['data']['name'] != null ? response['data']['name'] : "");
                              userData.updateLocation(response['data']['city'] != null ? response['data']['city'] : "");
                              userData.updateMobileNumber(
                                  response['data']['mob_number'] != null ? response['data']['mob_number'] : "");

                              if (response['data']['image'] != null) {
                                userData.updateProfileImage(response['data']['image']);
                                SharedPreferences.getInstance()
                                    .then((value) => value.setString('profileImage', response['data']['image']));
                              }

                              userData.updateId(response['data']['id'] != null ? response['data']['id'] : 0);
                              Fluttertoast.showToast(
                                  msg: response['message'],
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1);
                              Navigator.pop(context);
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              Fluttertoast.showToast(
                                  msg: "We have Some Internal Issue",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1);
                            }
                          });
                        }
                      },
                      child: Container(
                        height: 5.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(97, 125, 45, 1),
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      profileImage = pickedFile!.path;
    });
  }

  void updateNumber() {
    if (_nodeText2.hasFocus) _nodeText2.unfocus();
    if (userData.getUserData.mobile != _phoneController.text) {
      if (_phoneController.text.length == 10) {
        setState(() {
          isLoading = true;
        });
        Map<String, String> data = {
          "mobile": _phoneController.text,
        };
        ApiProvider.updateMobile(data).then((response) {
          if (response['result'] != null && response['result']) {
            Fluttertoast.showToast(
                msg: response['message'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
            setState(() {
              isLoading = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => VerifyOtpPage(
                  phone: _phoneController.text,
                ),
              ),
            );
          } else {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(
                msg: "Please Try Later",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1);
          }
        });
      }
    } else {
      Fluttertoast.showToast(
          msg: "Same Number Can't be update",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1);
    }
  }
}
