import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

final mobileNumValidator = MultiValidator([
  RequiredValidator(errorText: 'Mobile Number/Email  is required'),
]);
final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
]);

Widget passwordIconDecoration(icon, Function changeVisibility) {
  return InkWell(
    onTap: () {
      changeVisibility();
      print("pressed");
    },
    child: Icon(
      icon,
      size: 28,
      color: Color.fromRGBO(115, 167, 19, 0.6),
    ),
  );
}

Widget passwordPhoneField(GlobalKey globalKey, TextEditingController phoneCont) {
  return Form(
    key: globalKey,
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (value) {},
      keyboardType: TextInputType.number,
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
        hintText: "Enter your mobile number/email",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 11.sp),
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

Widget otpFieldForgetPassword(context, TextEditingController cont) {
  final node = FocusScope.of(context);
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
      onFieldSubmitted: (value) {},
      onChanged: (value) {
        if (value.length == 1) {
          node.nextFocus();
        }
      },
      keyboardType: TextInputType.phone,
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

Widget forgetPasswordField(
  IconData suffixIcon,
  TextEditingController cont,
  bool visible,
  Function changeVisibility,
) {
  return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      controller: cont,
      obscureText: visible,
      style: TextStyle(fontSize: 14.sp, decoration: TextDecoration.none),
      cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(32, 14, 12, 14),
        suffixIcon: passwordIconDecoration(suffixIcon, changeVisibility),
        helperText: "",
        helperStyle: TextStyle(height: 0.5),
        errorStyle: TextStyle(height: 0.5),
        hintText: "New Password",
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
      validator: passwordValidator);
}

Widget cnfforgetPasswordField(
  IconData suffixIcon,
  TextEditingController cont,
  bool visible,
  Function changeVisibility,
) {
  return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      controller: cont,
      obscureText: visible,
      style: TextStyle(fontSize: 14.sp, decoration: TextDecoration.none),
      cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(32, 14, 12, 14),
        suffixIcon: passwordIconDecoration(suffixIcon, changeVisibility),
        helperText: "",
        helperStyle: TextStyle(height: 0.5),
        errorStyle: TextStyle(height: 0.5),
        hintText: "Confirm New Password",
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
      validator: passwordValidator);
}
