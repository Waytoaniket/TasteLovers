import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

final requiredValidator = RequiredValidator(errorText: 'This field is required');

final emailValidator = MultiValidator(
    [RequiredValidator(errorText: 'Email is required'), EmailValidator(errorText: 'enter a valid email address')]);
final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'password must have special character')
]);

Widget textInputField(FocusNode node, String hintText, TextEditingController cont) {
  return TextFormField(
    focusNode: node,
    onEditingComplete: node.nextFocus,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: TextInputType.name,
    controller: cont,
    style: TextStyle(fontSize: 14.sp, decoration: TextDecoration.none),
    cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(32, 14, 12, 14),
      helperText: "",
      helperStyle: TextStyle(height: 0.5),
      errorStyle: TextStyle(height: 0.5),
      hintText: hintText,
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
    validator: requiredValidator,
  );
}

Widget emailInputField(FocusNode node, String hintText, TextEditingController cont) {
  return TextFormField(
    focusNode: node,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    onEditingComplete: () => node.nextFocus(),
    keyboardType: TextInputType.emailAddress,
    controller: cont,
    style: TextStyle(fontSize: 14.sp, decoration: TextDecoration.none),
    cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(32, 14, 12, 14),
      helperText: "",
      helperStyle: TextStyle(height: 0.5),
      errorStyle: TextStyle(height: 0.5),
      hintText: hintText,
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
    validator: emailValidator,
  );
}

Widget passwordField(
    FocusNode node, IconData suffixIcon, TextEditingController cont, bool visible, Function changeVisibility) {
  return TextFormField(
      focusNode: node,
      onEditingComplete: node.nextFocus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      controller: cont,
      obscureText: visible,
      style: TextStyle(fontSize: 14.sp, decoration: TextDecoration.none),
      cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(32, 14, 12, 14),
        suffixIcon: passwordIconDecoration(suffixIcon, changeVisibility),
        helperText: "",
        helperStyle: TextStyle(height: 0.5),
        errorStyle: TextStyle(height: 0.5),
        hintText: "Password",
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

Widget confirmPasswordField(FocusNode node, IconData suffixIcon, TextEditingController cont, TextEditingController pass,
    bool visible, Function changeVisibility) {
  return TextFormField(
    focusNode: node,
    onEditingComplete: node.nextFocus,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: TextInputType.visiblePassword,
    controller: cont,
    obscureText: visible,
    style: TextStyle(fontSize: 14.sp, decoration: TextDecoration.none),
    cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(32, 14, 12, 14),
      suffixIcon: passwordIconDecoration(suffixIcon, changeVisibility),
      helperText: "",
      helperStyle: TextStyle(height: 0.5),
      errorStyle: TextStyle(height: 0.5),
      hintText: "Confirm Password",
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
    validator: (val) => MatchValidator(errorText: 'passwords do not match').validateMatch(cont.text, pass.text),
  );
}

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

Widget getDropDownInput(String state, Function changeValue) {
  final List<String> _data = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand,',
    'West Bengal',
  ];

  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black54),
      borderRadius: BorderRadius.circular(6.w),
    ),
    child: Row(
      children: [
        Container(margin: EdgeInsets.only(left: 2.w), child: Image.asset("assets/registration/Marker.png")),
        Expanded(
          child: DropdownButton<String>(
            underline: Container(),
            elevation: 0,
            iconSize: 0,
            items: _data.map((String val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(
                  val,
                  style: TextStyle(color: Colors.black, fontSize: 12.sp),
                ),
              );
            }).toList(),
            hint: Container(
              margin: EdgeInsets.only(right: 4.h),
              alignment: Alignment.center,
              child: Text(
                state,
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
            ),
            isExpanded: true,
            onChanged: (String? val) {
              changeValue(val);
            },
          ),
        ),
      ],
    ),
  );
}
