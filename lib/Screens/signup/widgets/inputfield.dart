import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

final mobileNumValidator = MultiValidator([
  RequiredValidator(errorText: 'Mobile Number is required'),
  PatternValidator(r'^[6-9]\d{9}$', errorText: 'Enter valid phone Number')
]);
Widget field(FocusNode node, GlobalKey globalKey, TextEditingController phoneCont) {
  return Form(
    key: globalKey,
    child: TextFormField(
      focusNode: node,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (value) {},
      keyboardType: TextInputType.phone,
      controller: phoneCont,
      style: TextStyle(fontSize: 14.sp),
      textAlign: TextAlign.center,
      maxLength: 10,
      decoration: InputDecoration(
        counterText: "",
        helperText: "",
        helperStyle: TextStyle(height: 0.5),
        errorStyle: TextStyle(
          height: 0.5,
        ),
        hintText: "Enter your mobile number",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(115, 167, 19, 0.6)),
          borderRadius: BorderRadius.circular(6.w),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: mobileNumValidator,
    ),
  );
}
