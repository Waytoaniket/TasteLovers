import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget description(TextEditingController cont) {
  return Container(
    margin: EdgeInsets.only(top: 4.h),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          "assets/reviews/description.png",
          height: 3.h,
          width: 3.h,
          fit: BoxFit.fill,
        ),
        Container(
          width: 60.w,
          margin: EdgeInsets.only(left: 2.h),
          child: TextFormField(
            controller: cont,
            minLines: 1,
            maxLines: 5,
            cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
            style: TextStyle(fontSize: 12.sp),
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              isDense: true,
              counterText: "",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 12.sp,
              ),
              hintText: "Write a review",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(115, 167, 19, 0.6),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(115, 167, 19, 0.6),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
