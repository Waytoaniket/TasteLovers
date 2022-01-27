import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DatePicker extends StatelessWidget {
  final TextEditingController dateController;

  const DatePicker({Key? key, required this.dateController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputBorder roundedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(2.w)),
      borderSide: BorderSide(color: Colors.black, width: 0.5),
    );
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 2.h),
            child: Text(
              "Pick a date",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 45.w,
                child: IgnorePointer(
                  child: TextFormField(
                    controller: dateController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12.sp, letterSpacing: 1.5),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      enabledBorder: roundedBorder,
                      focusedBorder: roundedBorder,
                      border: roundedBorder,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 1.2.h),
                      helperText: "",
                      helperStyle: TextStyle(height: 0.5),
                      errorStyle: TextStyle(height: 0.5),
                      hintText: "DD-MM-YY",
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                  lastDate: DateTime(DateTime.now().year + 1),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData.dark().copyWith(
                        colorScheme: ColorScheme.dark(
                          primary: Color.fromRGBO(115, 167, 19, 1),
                          onPrimary: Colors.white,
                          surface: Color.fromRGBO(115, 167, 19, 0.4),
                          onSurface: Color.fromRGBO(115, 167, 19, 1),
                        ),
                        dialogBackgroundColor: Colors.white,
                      ),
                      child: child!,
                    );
                  },
                ).then(
                  (value) {
                    if (value != null) dateController.text = DateFormat('dd-MM-yy').format(value);
                  },
                ),
                child: Container(margin: EdgeInsets.only(left: 2.h), child: Image.asset("assets/booking/date.png")),
              )
            ],
          )
        ],
      ),
    );
  }
}
