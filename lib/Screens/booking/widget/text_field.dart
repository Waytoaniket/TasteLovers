import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget textfeild(var _con) {
  return Container(
    height: 5.h,
    width: 60.w,
    child: TextField(
      controller: _con,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
      ),
    ),
  );
}
