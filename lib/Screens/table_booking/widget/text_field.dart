import 'package:blue_witcher/Screens/table_booking/state/table_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

final requiredValidator = RequiredValidator(errorText: 'This field is required');

Widget textfeild(TextEditingController cont, context) {
  return Container(
    height: 7.h,
    width: 60.w,
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      onChanged: (val) => Provider.of<TableState>(context, listen: false).changeCouponVaild(),
      controller: cont,
      cursorColor: Colors.black12,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10),
        helperText: "",
        helperStyle: TextStyle(height: 0.5),
        errorStyle: TextStyle(height: 0.5),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: requiredValidator,
    ),
  );
}
