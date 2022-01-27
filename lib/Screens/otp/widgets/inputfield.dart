import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget otpField(FocusNode node, BuildContext context, TextEditingController cont) {
  return Container(
    width: 12.w,
    height: 12.w,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0.0, 2.0), //(x,y)
          blurRadius: 4.0,
        ),
      ],
    ),
    child: TextFormField(
      focusNode: node,
      onChanged: (value) {
        if (value.length == 1) {
          node.nextFocus();
        }
      },
      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
      cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
      controller: cont,
      textAlign: TextAlign.center,
      maxLength: 1,
      decoration: InputDecoration(
        counterText: "",
        errorStyle: TextStyle(
          height: 0.5,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(115, 167, 19, 0.6)), borderRadius: BorderRadius.zero),
        filled: true,
        fillColor: Colors.white,
      ),
    ),
  );
}
