import 'package:blue_witcher/Screens/setting/setting.dart';
import 'package:blue_witcher/Screens/state/user_data_state.dart';
import 'package:blue_witcher/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileCard extends StatelessWidget {
  final String? imageUrl;
  const ProfileCard({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataState>(builder: (_, userstate, child) {
      return Container(
        height: 32.h,
        width: 100.w,
        padding: EdgeInsets.only(top: 4.h),
        decoration: BoxDecoration(
          color: Color.fromRGBO(115, 167, 19, 0.5),
        ),
        child: Center(
          child: Container(
            height: 22.h,
            width: 85.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.w),
                boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 4.0)]),
            child: Container(
              padding: EdgeInsets.all(1.5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 13.h,
                        width: 13.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 2.0)]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.5.h),
                          child: FadeInImage(
                            image: NetworkImage(Constants.imageBaseUrl + userstate.getUserData.profileImageUrl),
                            placeholder: AssetImage('assets/home/loader3.gif'),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset("assets/home/noprofile.png", fit: BoxFit.cover);
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 6.1.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Text(
                                      userstate.getUserData.firstName + " " + userstate.getUserData.lastName,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_rounded),
                                      SizedBox(
                                        width: 1.w,
                                      ),
                                      Text(
                                        userstate.getUserData.city,
                                        style: TextStyle(fontSize: 10.sp),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "2304",
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "|",
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                      Container(width: 8.w, height: 8.w, child: Image.asset("assets/profile/message.png")),
                      Text(
                        "2304",
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "|",
                        style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Setting.id);
                        },
                        child: Container(width: 8.w, height: 8.w, child: Icon(Icons.settings)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
