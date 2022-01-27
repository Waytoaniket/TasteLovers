import 'package:blue_witcher/Screens/setting/widget/setting_card.dart';
import 'package:blue_witcher/Screens/update_profile/update_profile.dart';
import 'package:blue_witcher/authenticate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class Setting extends StatelessWidget {
  static const String id = "Setting";

  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
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
                "Settings",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, UpdatePtofile.id);
                },
                child: settingCard("assets/setting/updateProfile.png", "Update Profile")),
            InkWell(
                onTap: () {
                  SharedPreferences.getInstance().then((value) => value.clear());
                  Navigator.pushNamedAndRemoveUntil(context, Authenticate.id, (route) => false);
                },
                child: settingCard("assets/setting/Exit.png", "Logout"))
          ],
        ),
      ),
    );
  }
}
