import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sizer/sizer.dart';

final requiredValidator = RequiredValidator(errorText: 'This field is required');

final emailValidator = MultiValidator(
    [RequiredValidator(errorText: 'Email is required'), EmailValidator(errorText: 'enter a valid email address')]);

final mobileNumValidator = MultiValidator([
  RequiredValidator(errorText: 'Mobile Number is required'),
  PatternValidator(r'^[6-9]\d{9}$', errorText: 'Enter valid phone Number')
]);

Widget profileNameOrEmailField(
    FocusNode node, String hintText, TextEditingController cont, IconData icon, InputFieldType type) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: 4.5.h,
        color: Colors.grey[600],
      ),
      SizedBox(
        width: 4.w,
      ),
      Container(
        width: 62.w,
        child: TextFormField(
          focusNode: node,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onEditingComplete: InputFieldType.City == type ? node.unfocus : node.nextFocus,
          keyboardType: InputFieldType.Email == type ? TextInputType.emailAddress : TextInputType.name,
          controller: cont,
          style: TextStyle(fontSize: 12.sp),
          cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            helperText: "",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(115, 167, 19, 0.6),
              ),
            ),
            labelText: hintText,
            labelStyle: TextStyle(color: Colors.grey, fontSize: 13.sp, height: 1.7),
            helperStyle: TextStyle(height: 0.5),
            errorStyle: TextStyle(height: 0.5),
            filled: true,
            fillColor: Colors.white,
          ),
          validator: InputFieldType.Email == type ? emailValidator : requiredValidator,
        ),
      )
    ],
  );
}

Widget profilePhoneField(
    FocusNode node, String hintText, TextEditingController cont, IconData icon, Function callback) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
        icon,
        size: 4.5.h,
        color: Colors.grey[600],
      ),
      SizedBox(
        width: 4.w,
      ),
      Stack(
        children: [
          Container(
            width: 62.w,
            child: TextFormField(
              focusNode: node,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onEditingComplete: node.nextFocus,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              controller: cont,
              style: TextStyle(fontSize: 12.sp, decoration: TextDecoration.none),
              cursorColor: Color.fromRGBO(115, 167, 19, 0.6),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                counterText: "",
                helperText: "",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(115, 167, 19, 0.6),
                  ),
                ),
                labelText: hintText,
                labelStyle: TextStyle(color: Colors.grey, fontSize: 13.sp, height: 1.7),
                helperStyle: TextStyle(height: 0.5),
                errorStyle: TextStyle(height: 0.5),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: mobileNumValidator,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 6,
            child: InkWell(
              onTap: () => callback(),
              child: Container(
                height: 4.h,
                child: Text(
                  "Update",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(62, 89, 11, 1),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ],
  );
}

enum InputFieldType { Email, Name, City }
