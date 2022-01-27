import 'package:blue_witcher/Screens/home/state/location_service.dart';
import 'package:blue_witcher/Screens/profile/profile_page.dart';
import 'package:blue_witcher/Screens/state/user_data_state.dart';
import 'package:blue_witcher/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Widget getHeader(context) {
  LocationService _locationservice = Provider.of<LocationService>(context, listen: false);
  return Container(
    margin: EdgeInsets.only(top: 6.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            _locationservice.getCurrentLocation();
          },
          child: Container(
            width: 35.w,
            height: 5.h,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.w), boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0),
            ]),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Image.asset("assets/registration/Marker.png"),
                ),
                Padding(
                  padding: EdgeInsets.all(1.w),
                  child: Text(
                    _locationservice.currentLocation != null ? _locationservice.currentLocation! : "Location",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11.sp),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProfilePage.id);
          },
          child: Container(
            height: 6.h,
            width: 6.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 2.0)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3.h),
              child: Consumer<UserDataState>(
                builder: (_, userstate, child) {
                  return FadeInImage(
                    image: NetworkImage(Constants.imageBaseUrl + userstate.getUserData.profileImageUrl),
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
        )
      ],
    ),
  );
}
