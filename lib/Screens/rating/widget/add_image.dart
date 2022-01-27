import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class AddImages extends StatefulWidget {
  Function addImage;
  Function removeImage;
  AddImages({Key? key, required this.addImage, required this.removeImage}) : super(key: key);

  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  String images = "";
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Column(
        children: [
          InkWell(
            onTap: () => getImage(),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/reviews/addimage.png",
                    height: 3.5.h,
                    width: 3.5.h,
                    fit: BoxFit.fill,
                  ),
                  Container(
                    width: 60.w,
                    margin: EdgeInsets.only(left: 2.h),
                    child: Text(
                      "Add images",
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
          ),
          images.isNotEmpty
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 1.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => remove(),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 1.w),
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all()),
                          child: Icon(
                            Icons.close,
                            size: 1.5.h,
                          ),
                        ),
                      ),
                      Image.file(
                        File(images),
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 10.h,
                ),
        ],
      ),
    );
  }

  void getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      images = pickedFile!.path;
      widget.addImage(images);
    });
  }

  void remove() {
    setState(() {
      images = "";
      widget.removeImage();
    });
  }
}
